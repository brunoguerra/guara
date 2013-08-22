require 'spec_helper'

module Guara
  describe ActiveCrm::Scheduled::Deal do
    let(:scheduled) {  Factory(:scheduled) }
    let(:scheduled_group) {  Factory(:scheduled_group, scheduled_id: scheduled.id) }
    let(:customers_on_group) { Array.new(3) { Factory(:customer_pj, :total_employes => 100) } }

    let (:contacted_customer)     { Factory :scheduled_contact, deal: @deal }

    before do

      @deal = Guara::ActiveCrm::Scheduled::Deal.new(
        customer_id: customers_on_group.first.id,
        group: scheduled_group 
      )
    end

    it { should respond_to(:customer) }
    it { should respond_to(:customer_id) }
    it { should respond_to(:group) }
    it { should respond_to(:group_id) }

    it { should respond_to(:contacts) }

    it "lists all contacts of customer contacted" do
      contacted_customer #pre-data
      expect(@deal.contacted.count).to be(1) 
    end
    
  end
end