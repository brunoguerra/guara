require 'spec_helper'

module Guara
  describe CustomerFinancial do
  
    let (:customer) { Factory(:customer_pj).customer }
  
    before do
      @financial_data = CustomerFinancial.new(
                          :customer => customer,
                          :contact_leader_id => Factory(:contact, :customer => customer).id,
                          :notes => Faker::Lorem.sentence(100)[1..1000]       
                        )
    
    end
  
    subject { @financial_data }


    it { should respond_to(:customer) }
    it { should respond_to(:leader) }
    it { should respond_to(:billing_address_different) }  
    it { should respond_to(:billing_addresses) }
    it { should respond_to(:payment_pending) }
    it { should respond_to(:payment_pending_message) }
    it { should respond_to(:notes) }
  
    describe "Billing Address Different" do
      let!(:address) do
        Address.new(
          :state => State.first,
          :city => City.first,
          :district => Factory(:district),
          :address => Faker::Lorem.sentence(2)[1..120],
          :postal_code => "60000100",
          :addressable => @financial_data
        )
      end
    
      before do
        @financial_data.billing_address_different = true
        @financial_data.billing_addresses << address
      end
    
      its(:billing_addresses) { should include(address) }
  
    end
  
  end
end