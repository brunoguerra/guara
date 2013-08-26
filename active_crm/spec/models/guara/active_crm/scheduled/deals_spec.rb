require 'spec_helper'

module Guara
  describe ActiveCrm::Scheduled::Deal do
    let(:scheduled) {  Factory(:scheduled) }
    let(:scheduled_group) {  Factory(:scheduled_group, scheduled_id: scheduled.id) }
    let(:customers_on_group) { Array.new(3) { Factory(:customer_pj, :total_employes => 100) } }

    before do

      @deal = Guara::ActiveCrm::Scheduled::Deal.new(
        customer: customers_on_group.first.customer,
        group: scheduled_group,
        scheduled:  scheduled_group.scheduled
      )
    end

    subject { @deal }

    it { should respond_to(:customer) }
    it { should respond_to(:customer_id) }
    it { should respond_to(:group) }
    it { should respond_to(:group_id) }

    it { should respond_to(:contacts) }

    it { should be_valid }

    #with customer
    let (:contacted_customer)     { Factory :scheduled_contact, deal: @deal }

    it "lists all contacts of customer contacted" do
      @deal.save!
      contacted_customer #pre-data
      expect(@deal.contacts.count).to be(1) 
    end
    
  end
end