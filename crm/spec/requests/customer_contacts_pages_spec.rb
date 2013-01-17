require 'spec_helper'

describe "Contacts Customer" do
  
  subject { page }
  
  #login
  let(:user) { FactoryGirl.create(:user) }
  
  #customer neasted
  let(:customer) { FactoryGirl.create(:customer_pj).customer }
  
  before do
    able_update(user, SystemModule.CUSTOMER)
    able_update(user, SystemModule.CONTACT)
    sign_in user
  end
  
  describe "access in customer form" do
    before do
       visit edit_customer_path(customer)
    end
    
    it { should have_selector("title", text: I18n.t("customers.edit.title")) }
    it { have_link(I18n.t('customer.contacts.link'), href: customer_contacts_path(customer)) }
    
    it "acess contacts from customers" do
       click_link I18n.t('contacts.index.link')
       should have_selector("title", text: I18n.t("contacts.title", :customer => customer.name))
    end
  end
  
  describe "creation" do
    before do
       able_create(user, SystemModule.CONTACT)
       visit new_customer_contact_path(customer)
    end
    
    describe "with invalid information" do
      it "it should not change contacts" do
        expect { click_button autotitle_create('Contact') }.to_not change(Contact, :count)
      end
    end
    
    describe "with invalid information" do
      let(:name) { "Contact test" }
      before do
        fill_in I18n.t("contacts.name"),     with: name
      end
      it "it should create contact" do
        expect { click_button autotitle_create('Contact') }.to change(Contact, :count).by(+1)
      end
    end
    
  end
  
  describe "show customer side panel" do
    before :each do
      @contacts = []
      @departments = [Factory(:business_department), Factory(:business_department)]
      10.times { |i| @contacts << Factory(:contact, customer:customer, department: @departments[i / 5]) }
      
      visit customer_path(customer)
    end
    
    it "should find all cantacts in list" do
      @contacts.each do |contact|
        should have_selector '#contact%d' % contact.id, text: contact.name
      end
    end
    
    it { should have_content I18n.t("contacts.side.title") }
    
    describe "select department filter", :js => true do
      before do
        wait_for_animations()
        find("#select_department #%d" % @departments[0].id).click()
        wait_for_response()
      end
      
      it "should only apears contacts of clicked department!" do
        @contacts.each do |contact|
          if contact.department == @departments[0]
            #find('#contact%d' % contact.id).should have_content contact.name
            should have_css('#contact%d' % contact.id, text: contact.name)
          else
            should_not have_css('#contact%d' % contact.id, text: contact.name)
          end
        end
      end
      
    end
    
  end
  
end