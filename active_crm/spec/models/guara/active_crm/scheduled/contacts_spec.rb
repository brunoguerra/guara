require 'spec_helper'

module Guara::ActiveCrm
  describe Scheduled::Contact do

    let(:customer) { Factory(:customer_pj).customer }
    let(:customer_contact) { Factory(:contact, customer: customer) }
    let(:deal) { Factory(:scheduled_deals, customer: customer) }

    before { @contact = Scheduled::Contact.new(
                                    person: customer,
                                    contact: customer_contact,
                                    deal: deal,
                                    activity: "OK, contacted! just now... \n"+Faker::Lorem.paragraphs(3).join(", "),
                                    result: Scheduled::Contact::ACCEPTED) 
    }

    subject { @contact }

    it { should respond_to(:deal) }
    it { should respond_to(:contact) }
    it { should respond_to(:person) } #contact not live forever
    it { should respond_to(:created_at) } #important - very useful
    it { should respond_to(:updated_at) }

    it { should respond_to(:scheduled_at) }

    it { should respond_to(:join_to_opened_deal) }
    it { should respond_to(:join_to_opened_deal_or_create) }

    it { should be_valid }

    context "with invalid relationships" do
      it "validate presence of person" do
        @contact.person = nil
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

    it "#join_to_opened_deal - checks existing a deal from scheduled and join to one" do
      @contact.deal = nil
      @contact.scheduled = deal.scheduled
      expect(@contact.join_to_opened_deal).to be_valid
    end

    context "#join_to_opened_deal_or_create" do 
      before do
        @scheduled = deal.scheduled
        deal.destroy
        @contact.deal = nil
        @contact.scheduled = @scheduled
      end
      
      it "checks not existent Deal from scheduled and create one" do
        expect(@contact.join_to_opened_deal_or_create).to be_valid
      end

      it "checks not existent Deal from scheduled" do
        expect(@contact.join_to_opened_deal.deal).to be_nil
      end
    end

    context "#cerate" do
      it "creates a deal" do
        @scheduled = deal.scheduled
        deal.destroy
        @contact.deal = nil
        @contact.scheduled = @scheduled
        expect{ @contact.save }.to change{ Scheduled::Deal.count }.by(1)
      end

      it "joins a existing deal" do
        @contact.scheduled = @contact.deal.scheduled
        @contact.deal = nil
        expect{ @contact.save }.to change{ Scheduled::Deal.count }.by(0)
      end

      it "ensures only one scheduled call/contact per contact of customer" do
        @contact.scheduled_at = 2.days.from_now
        @contact.change_to_scheduled
        @contact.save!
        new_contact = @contact.dup
        expect{ new_contact.save }.to change{ Scheduled::Contact.where(result: Scheduled::Contact::SCHEDULED_REALIZED).count }.by(1)
      end
    end



  end
end