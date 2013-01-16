require 'spec_helper'

module Guara
  describe CustomerPf do
  
    before do
      @customerPf = CustomerPf.new :department => "RH", :corporate_function => "Gestor"
    end
  
    subject { @customerPf }
  
    it { should respond_to(:department) }
    it { should respond_to(:corporate_function) }
  
    describe "Relationship 1 to 1 Customer" do
      before do 
        customer = Customer.new(:name => "Teste n");
        @customerPf.customer = customer
      end
    
      it { should be_valid }
    end
  
  end
end