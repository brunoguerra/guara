require 'spec_helper'

module Guara
  describe ActiveCrm::Scheduled::Contact do

    let(:customer) { Factory(:customer_pj).customer }
    let(:customer_contact) { Factory(:contact, customer: customer) }
    let(:deal) { Factory(:scheduled_deals, customer: customer) }

    before { @contact = ActiveCrm::Scheduled::Contact.new(
                                    person: customer,
                                    contact: customer_contact,
                                    deal: deal,
                                    activity: "OK, contacted! just now... \n"+Faker::Lorem.paragraphs(3).join(", "),
                                    result: ActiveCrm::Scheduled::Contact::ACCEPTED) 
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

    it "#join_to_opened_deal - checks existing a deal from scheduled and join to one" do
      @contact.deal = nil
      expect(@contact.join_to_opened_deal(deal.scheduled)).to be_valid
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
        expect{ @contact.save }.to change{ ActiveCrm::Scheduled::Deal.count }.by(1)
      end

      it "joins a existing deal" do
        @contact.scheduled = @contact.deal.scheduled
        @contact.deal = nil
        expect{ @contact.save }.to change{ ActiveCrm::Scheduled::Deal.count }.by(0)
      end
    end



  end
end