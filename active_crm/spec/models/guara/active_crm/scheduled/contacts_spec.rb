require 'spec_helper'

module Guara
  describe ActiveCrm::Scheduled::Contact do

    let(:customer) { Factory(:customer_pj).customer }
    let(:customer_contact) { Factory(:contact, customer: customer) }
    let(:deal) { Factory(:scheduled_group_deals, customer: customer) }

    before { @contact = ActiveCrm::Scheduled::Contact.new(customer: customer,
                                    contact: customer_contact,
                                    deal: deal,
                                    activity: "OK, contacted! just now... \n"+Faker::Lorem.paragraphs(3).join(", "),
                                    result: ActiveCrm::Scheduled::Contact::ACCEPTED) }

    subject { @contact }

    it { should respond_to(:deal) }
    it { should respond_to(:contact) }
    it { should respond_to(:customer) } #contact not live forever
    it { should respond_to(:created_at) } #important - very useful
    it { should respond_to(:updated_at) }

    it { should respond_to(:join_to_opened_deal) }
    it { should respond_to(:join_to_opened_deal_or_create) }

    it { should be_valid }

    context "with invalid relationships" do
      it "validate presence of deal" do
        @contact.deal = nil
        @contact.should_not be_valid
      end

      it "validate presence of customer" do
        @contact.customer = nil
        @contact.should_not be_valid
      end

      it "validate presence of contact" do
        @contact.contact = nil
        @contact.should_not be_valid
      end
    end

    context "when create new" do
      it "checks existing a deal from scheduled and join to one" do
        @contact.deal = nil
        @contact.join_to_opened_deal(deal.scheduled).should be_valid
      end

      context "when not exists a Deal" do 
        before do
          @scheduled = deal.scheduled
          deal.destroy
          @contact.deal = nil
        end
        
        it "checks not existent Deal from scheduled and create one" do
          @contact.join_to_opened_deal_or_create(@scheduled).should be_valid
        end

        it "checks not existent Deal from scheduled" do
          @contact.join_to_opened_deal(@scheduled).deal.should be_nil
        end
      end
    end



  end
end