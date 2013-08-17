require 'spec_helper'
require File.expand_path('../contact_customers_page_util', __FILE__)

feature "Active CRM - Management Sell by Phone and e-mail", %{
  As a Telemarketing Caller
  I want to schedule calls before sales begins
  In order to effective result cantancting customers by phone and e-mail
  } do

  #group target
  given(:group) { Factory(:scheduled_group) }

  background do
    @user = FactoryGirl.create(:user)
    make_user_abilities
    sign_in @user
  end

  #page objects
  given(:to_contact_page)   { Guara::ActiveCrm::ContactCustomersPageUtil.new(group, @user) } #the directors show
  given(:customer_on_page)  { to_contact_page.customer_on_page(customer) } #the supporting show

  #customers
  given(:customer)          { Factory(:customer_pj, total_employes: 100).customer }
  given(:list_customers)    { (1..3).collect { Factory(:customer_pj, total_employes: 100).customer } + [customer] }

  scenario "list users match group params" do
      list_customers #pre-data
      #steps
      to_contact_page.show_group
      #expectable
      expect(customer_on_page).to be_contactable
  end

  scenario "show csutomer to call", :js => true, :no_driver => :selenium do
    list_customers #pre-data
    #steps
    to_contact_page.show_group
    customer_on_page.click
    #expectable
    expect(customer_on_page).to be_visible
  end

  given(:contact_on_page)   { customer_on_page.contact_on_page }
  given(:contact_by_phone)  { contact_on_page.contact_by_phone }
  given(:deal_on_page)      { contact_by_phone.deal_on_page }

  scenario "contacting a customer with success", :js => true do
    list_customers #pre-data
    #steps
    to_contact_page.show_group
    customer_on_page.have(2).contacts #test ajax loading should recent created contacts
    customer_on_page.click
    #wait ajax response
    expect(customer_on_page).to be_visible
    contact_on_page.click
    contact_by_phone.create
    #expectable
    expect(deal_on_page).to be_visible
  end


  # ==================================================================
  #user accebilty
  def make_user_abilities
    able @user, :read, 'customer'
    able @user, :read, 'contact'
    able @user, [:read, :create, :update, :delete], 'Guara::ActiveCrm::Scheduled'
    able @user, [:read, :create, :update, :delete], 'Guara::ActiveCrm::Scheduled::CustomerGroup'
    able @user, [:read, :create, :update, :delete], 'Guara::ActiveCrm::Scheduled::Contact'
    able @user, :read, 'Guara::ActiveCrm::Scheduled::Deal'
  end

end
