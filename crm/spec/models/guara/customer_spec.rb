require 'spec_helper'

include Guara::LocaleHelparams[:id]per

module Guara
  describe Customer do
    before do
    
     #:doc, :doc_rg, :name, :name_sec, :address, :birthday, :state_id, :city_id, :district_id, :customer_pj, :is_customer
     @customer = Customer.new(doc: "23532278000105", doc_rg: "000182", name: "Example Customer", name_sec: "Name Sec",
                                address: "Rua B, Plano A",
                                birthday: "19/01/1900", 
                                state: FactoryGirl.create(:state),
                                city: FactoryGirl.create(:city),
                                district: FactoryGirl.create(:district),
                                phone: 9)
                              
     end
   
     subject { @customer }
   
     it { should respond_to :name }
     it { should respond_to :name_sec }
   
     it { should respond_to :doc }
     it { should respond_to :doc_rg }
     it { should respond_to :birthday }
     it { should respond_to :state }
     it { should respond_to :city }
     it { should respond_to :district }
     it { should respond_to :phone }
     it { should respond_to :address }
   
     it { should respond_to :notes }
     it { should respond_to :other_contacts }
   
     it { should respond_to :emails }
     it { should respond_to :complete? }
   
     it { should respond_to :contacts }
   
     it { should respond_to :businesses }

     it { Customer.should respond_to :search_by_name }
      
     it { should be_valid }
   
     it "MassAssignmentSecurity" do
       expect do
         @customer.notes = ""
       end.to_not raise_error(:MassAssignmentSecurity)
     end
   
     describe "when record is complete" do
       describe "require essencials fields" do
         before do
           @customer.complete = true
           @customer.doc = ""
         end
         it { should be_invalid }
       end
     end
   
     describe "Relationships" do
        before do
          @customer.save
        end
      
        let(:contact)       { FactoryGirl.create(:contact, customer: @customer) }
        let(:contact_other) { FactoryGirl.create(:contact, customer: @customer) }
      
        it "has_many contacts" do
          @customer.contacts.should include(contact, contact_other)
        end
      
     end
   
     describe "Complete" do
       before do
         @customer.complete = false
       end
     
       it { should be_can_complete }
       it { should_not be_complete }
     
       describe "change field complete after save" do
         before { @customer.save }
         it { should be_complete }
       end
     end
   
     describe "incomplete customer" do
       let(:incomplete) do
          Customer.new name: Faker::Name.first_name,
                       doc: ''
       end
       subject { incomplete }
     
       it { should be_valid  }
     
       describe "test can complete?" do
         before { incomplete.can_complete? }
         it { should be_valid }
       end
     
       describe "save!" do
         before { incomplete.save! }
         it { should be_valid }
       end
     end
   
     describe "after add task with business" do
       before do
         @date_finish = 1.day.ago
         @customer.tasks.clear
       
         @company_business = Factory(:company_business)
       
         @task = Factory(:task, interested: @customer)
         @task.type = Factory(:task_type)
         @task.type.company_business = @company_business
         @task.type.save
         @task.due_time = 2.days.ago
         @task.done
         @task.finish_time = @date_finish
         @task.resolution = SystemTaskResolution.RESOLVED_WITH_BUSINESS
       end

       it { expect { @task.save }.to change { @customer.businesses.length }.by(+1) }
     
       it "should display last businesses date" do
         @task.save
         @customer.businesses.each { |business| format_datetime(Time.parse(business.business_at.to_s)).should eq(format_datetime(@date_finish)) }
       end
     end
  end
end