require 'spec_helper'

include Guara::LocaleHelper

module Guara
  describe Customer do
    before do
    
     #:doc, :doc_rg, :name, :name_sec, :address, :birthday, :state_id, :city_id, :district_id, :customer_pj, :is_customer
     @person = Person.new(doc: "23532278000105", doc_rg: "000182", name: "Example Customer", name_sec: "Name Sec",
                                address: "Rua B, Plano A",
                                birthday: "19/01/1900", 
                                state: FactoryGirl.create(:state),
                                city: FactoryGirl.create(:city),
                                district: FactoryGirl.create(:district),
                                phone: 9)
                              
     end
   
     subject { @person }
   
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
     
     it { should respond_to :phone }
      
     it { should be_valid }
   
     it "MassAssignmentSecurity" do
       expect do
         @person.notes = ""
       end.to_not raise_error(:MassAssignmentSecurity)
     end
   
     describe "when record is complete" do
       describe "require essencials fields" do
         before do
           @person.complete = true
           @person.doc = ""
         end
         it { should be_invalid }
       end
     end
   
     describe "Relationships" do
        before do
          @person.save
        end
      
        let(:contact)       { Factory(:contact, customer: @person) }
        let(:contact_other) { Factory(:contact, customer: @person) }
      
        it "has_many contacts" do
          @person.contacts.should include(contact, contact_other)
        end
      
     end
   
     describe "Complete" do
       before do
         @person.complete = false
       end
     
       it { should be_can_complete }
       it { should_not be_complete }
     
       describe "change field complete after save" do
         before { @person.save }
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
         @person.tasks.clear
     
         @company_business = Factory(:company_business)
     
         @task = Factory(:task, interested: @person)
         @task.type = Factory(:task_type)
         @task.type.company_business = @company_business
         @task.type.save
         @task.due_time = 2.days.ago
         @task.done
         @task.finish_time = @date_finish
         @task.resolution = SystemTaskResolution.RESOLVED_WITH_BUSINESS
       end
     
       it { expect { @task.save }.to change { @person.businesses.length }.by(+1) }
     
       it "should display last businesses date" do
         @task.save
         @person.businesses.each { |business| format_datetime(Time.parse(business.business_at.to_s)).should eq(format_datetime(@date_finish)) }
       end
     end
  
    context "phones" do
      before do
        @phone = ["8599997777", "8599997788"]
        @person.phones_attributes = [
                                      { phone: @phone[0] }, 
                                      { phone: @phone[1] }
                                    ]
        @person.save
      end
      
      it { @person.phones.where(phone: @phone[0]).count() == 1 }
      it { @person.phones.where(phone: @phone[1]).count() == 1 }
      
      context "more 2" do
        before do
          @phone = ["8599997779", "8599997787"]
          @person.phones.each {|p| @person.phones_attributes = { :id => p.id, :_destroy => 1} }
          @person.phones_attributes = [
                                        { phone: @phone[0] }, 
                                        { phone: @phone[1] }
                                      ]
        end
        it "and only 2" do
          @person.phones.count.should eq(2) 
          expect { @person.save }.to change(Guara::Phone, :count).by(0)
        end
        
        it { @person.phones.where(phone: @phone[0]).count() == 1 }
        it { @person.phones.where(phone: @phone[1]).count() == 1 }
      end
    end
  
  end
end