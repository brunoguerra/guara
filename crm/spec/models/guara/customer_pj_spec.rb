require 'spec_helper'


module Guara
  describe CustomerPj do
  
    before do
    
      #:doc, :doc_rg, :name, :name_sec, :address, :birthday, :state_id, :city_id, :district_id, :customer_pj, :is_customer
       @customer = Customer.new(doc: "23532278000105",
                                doc_rg: "000182",
                                name: "Example Customer", name_sec: "Name Sec",
                                address: "Rua B, Plano A",
                                birthday: "19/01/1900",
                                state: FactoryGirl.create(:state),
                                city: FactoryGirl.create(:city),
                                district: FactoryGirl.create(:district))
                              
       @customer.customer = CustomerPj.new(fax: "859998887", total_employes: 230)
       @customer.save
       
       3.times { @customer.customer.customer_segments.build(segment: FactoryGirl.create(:business_segment)) }
                                  
       3.times { @customer.customer.customer_activities.build(activity: FactoryGirl.create(:business_activity)) }
     end
  
    subject { @customer.customer }
  
    it { should respond_to :fax }
    it { should respond_to :segments }
    it { should respond_to :activities }
  
    it { should respond_to(:associateds) }
    it { should respond_to(:associates) }
    it { should respond_to(:associate_to!) }
    
    it { should be_valid }

  
    describe "validate on default attributes" do
      describe "should be valid on CNPJ zeros" do
        before { @customer.doc = "0"*14 }
        it { should be_valid }
      end
    
    end
  
    describe "invalidate on invalid attributes" do
      describe " on CNPJs invalids " do
        before { @customer.doc = "00000000010000" }
        it { @customer.should_not be_valid }
      end
    end
    
    describe "accessible attributes" do
      it "should allow access to basics fields" do
        expect do
          @customer.save
        end.to_not raise_error(ActiveModel::MassAssignmentSecurity::Error)
      end    
    end
  
    describe "has many custemers_pj" do
      before do
        @customer.save
        @anothers_pj = Array.new(2) { Factory(:customer_pj) }
        @anothers_pj.each { |pj| @customer.customer.associate_to!(pj) }
      end
    
      it { @anothers_pj.each { |another_pj| @customer.customer.associateds.should include(another_pj) } }
    end
  
  end
end