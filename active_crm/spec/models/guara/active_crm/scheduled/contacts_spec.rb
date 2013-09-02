require 'spec_helper'

module Guara::ActiveCrm
  describe Scheduled::Contact do

    let(:customer) { Factory(:customer_pj).customer }
    let(:customer_contact) { Factory(:contact, customer: customer) }
    let(:deal) { Factory(:scheduled_deals, customer: customer) }
    let(:user) { Factory(:user) }

    before { @contact = Scheduled::Contact.new(
                                    contact: customer_contact,
                                    deal: deal,
                                    activity: "OK, contacted! just now... \n"+Faker::Lorem.paragraphs(3).join(", "),
                                    result: Scheduled::Contact::ACCEPTED,
                                    user: user) 
    }

    subject { @contact }

    it { should respond_to(:deal) }
    it { should respond_to(:contact) }
    it { should respond_to(:created_at) } #important - very useful
    it { should respond_to(:updated_at) }

    it { should respond_to(:scheduled_at) }

    it { Scheduled::Contact.results.should have(7).items }

    it { should be_valid }

    it { expect{ @contact.save }.to change{ Scheduled::Contact.count }.by(1) }

    context "with invalid relationships" do
      it "validate presence of person" do
        @contact.deal = nil
        @contact.should_not be_valid
      end

      it "validate presence of contact" do
        @contact.contact = nil
        @contact.should_not be_valid
      end
    end

    context ".validates" do
      before { @contact.result = Scheduled::Contact::SCHEDULED }
      
      it "invalidates scheduled with no scheduled_at" do
        @contact.scheduled_at = nil
        expect { @contact.save! }.to raise_error
      end

      it "invalidates scheduled with scheduled_at before today" do
        @contact.scheduled_at = 1.day.ago
        expect { @contact.save! }.to raise_error
      end
    end


    context "#cerate" do
      it "ensures only one scheduled call/contact per contact of customer" do
        @contact.scheduled_at = 2.days.from_now
        @contact.change_to_scheduled
        @contact.save!

        new_contact = @contact.dup
        expect{ new_contact.save }.to change{ Scheduled::Contact.where(result: Scheduled::Contact::SCHEDULED_REALIZED).count }.by(1)
      end

      it "ensures only one scheduled or not_contcted call/contact per contact of customer" do
        #scheduled
        new_contact = @contact.dup
        new_contact.scheduled_at = 1.days.from_now
        new_contact.change_to_scheduled
        new_contact.save!

        #not_contacted
        @contact.scheduled_at = 2.days.from_now
        @contact.change_to_not_contacted
        @contact.save!

        #new_scheduled
        new_contact = @contact.dup
        expect{ new_contact.save }.to change{ Scheduled::Contact.where(result: Scheduled::Contact::NOT_CONTACTED_REALIZED).count }.by(1)
      end

      it "ensures only one verdict accepted per contact" do
        #not_contacted
        @contact.scheduled_at = 2.days.from_now
        @contact.change_to_accepted
        @contact.save!

        #new_scheduled
        new_contact = @contact.dup
        new_contact.change_to_accepted        
        expect{ new_contact.save }.to change{ Scheduled::Contact.where(result: Scheduled::Contact::ACCEPTED_CHANGE).count }.by(1)
      end

      it "ensures only one verdict per contact" do
        #not_contacted
        @contact.scheduled_at = 2.days.from_now
        @contact.change_to_denied
        @contact.save!

        #new_scheduled
        new_contact = @contact.dup
        new_contact.change_to_accepted        
        expect{ new_contact.save }.to change{ Scheduled::Contact.where(result: Scheduled::Contact::DENIED_CHANGE).count }.by(1)
      end

      let(:ignored_customer) { Factory(:scheduled_ignored, customer: @contact.deal.customer, group: @contact.deal.group)}
      it "ensures after contact customers not more ignored" do
        ignored_customer
        expect { @contact.save! }.to change{ Scheduled::Ignored.count }.by(-1)
      end
    end
  end
end