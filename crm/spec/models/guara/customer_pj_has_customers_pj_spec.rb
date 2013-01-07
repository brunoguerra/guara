require 'spec_helper'


module Guara
  describe CustomerPjHasCustomersPj do
  
   let(:from) { Factory(:customer_pj) }
   let(:to) { Factory(:customer_pj) }
 
   before do
     @customer_pj_has_customers_pj = CustomerPjHasCustomersPj.new from: from,
                                                                  to:   to
   
   end
 
   subject { @customer_pj_has_customers_pj }
 
   it { should respond_to(:from) }
   it { should respond_to(:to) }
  
   its(:from) { should  be_a(CustomerPj) }
   its(:to) { should  be_a(CustomerPj) }


   it { @customer_pj_has_customers_pj.from.customer.name.should  be(from.customer.name) }  
   it { @customer_pj_has_customers_pj.to.customer.name.should be(to.customer.name) }
  
    describe "save" do
      before { @customer_pj_has_customers_pj.save }
      it { @customer_pj_has_customers_pj.from.customer.name.should  be(from.customer.name) }  
      it { @customer_pj_has_customers_pj.to.customer.name.should be(to.customer.name) }
    end
  

  
  end
end