require 'spec_helper'

module Guara::ActiveCrm
  describe Scheduled::Contact do

    let(:customer) { Factory(:customer_pj).customer }
    let(:customer_contact) { Factory(:contact, customer: customer) }
    let(:deal) { Factory(:scheduled_deals, customer: customer) }

    before { @contact = Scheduled::Contact.new(
                                    contact: customer_contact,
                                    deal: deal,
                                    activity: "OK, contacted! just now... \n"+Faker::Lorem.paragraphs(3).join(", "),
                                    result: Scheduled::Contact::ACCEPTED) 
    }

    subject { @contact }

    it { should respond_to(:deal) }
    it { should respond_to(:contact) }
    it { should respond_to(:created_at) } #important - very useful
    it { should respond_to(:updated_at) }

    it { should respond_to(:scheduled_at) }

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
        puts new_contact.to_yaml
        expect{ new_contact.save }.to change{ Scheduled::Contact.where(result: Scheduled::Contact::SCHEDULED_REALIZED).count }.by(1)
      end
    end
  end
end