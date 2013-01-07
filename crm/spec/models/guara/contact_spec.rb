require 'spec_helper'


module Guara
  describe Contact do
    before do   
       @contact = Contact.new(
                    name: 'Teste Contact 1',
                    birthday: 35.years.ago,
                    customer: Factory(:customer),
                    department: Factory(:business_department))
     end
   
     subject { @contact }

     it { should respond_to :name }
     it { should respond_to :birthday }
     it { should respond_to :phone }
     it { should respond_to :customer }
     it { should respond_to :emails }
     it { should respond_to :department }
     it { should respond_to :department_id }
      
     it { should be_valid }
   
     describe "require name" do
       before do
         @contact.name = ""
       end
       it { should be_invalid }
     end
   
     describe "require customer" do
       before do
         @contact.customer = nil
       end
       it { should be_invalid }
     end
   
     describe "emails associations" do
       let!(:email) { FactoryGirl.create(:email, emailable: @contact) }
       let!(:email_private) { FactoryGirl.create(:email, emailable: @contact, private: true) }
     
       it { @contact.emails.should == [email, email_private] }
     end
   
     describe "department" do
       before { @contact.department = BusinessDepartment.last }
       its(:department) { should == (BusinessDepartment.last) }
       its(:department_id) { should == (BusinessDepartment.last.id) }
     end
   
     describe "search" do
       before do
         @contact.save
         @contacts = Contact.search_by_params @contact.customer.contacts, department_id: nil
       end
       it { @contact.customer.contacts include(@contact) }
       it { @contacts.should include(@contact) }
     end
   
  end
end