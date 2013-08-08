require 'spec_helper'

module Guara
  describe ActiveCrm::Scheduled::Deals do
    let(:scheduled) {  Factory(:scheduled) }
    let(:scheduled_customer_group) {  Factory(:scheduled_customer_group, scheduled_id: scheduled.id) }
    let(:customers_on_group) { Array.new(3) { Factory(:customer_pj, :total_employes => 100) } }
    before do

      @deal = Guara::ActiveCrm::Scheduled::Deals.new(
        customer_pj: customers_on_group.first,
        group: scheduled_customer_group 
      )
    end

    it { should respond_to(:customer_pj) }
    it { should respond_to(:customer_pj) }
    it { should respond_to(:customer_pj) }
    it { should respond_to(:customer_pj) }
  end
end