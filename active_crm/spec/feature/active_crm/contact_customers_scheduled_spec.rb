require 'spec_helper'

feature "Active CRM - Management Sell by Phone and e-mail", %{
  As a Telemarketing Caller
  I want to schedule calls before sales begins
  In order to effective result cantancting customers by phone and e-mail
  } do


  given(:user) { Factory(:user) } #to login and call

  background do
    able user, :read, 'customer'
    able user, :read, 'contact'
    able user, [:read, :create, :update, :delete], 'Guara::ActiveCrm::Scheduled'
    able user, [:read, :create, :update, :delete], 'Guara::ActiveCrm::Scheduled::CustomerGroup'
    able user, [:read, :create, :update, :delete], 'Guara::ActiveCrm::Scheduled::Contact'
    able user, [:read, :create, :update, :delete], 'Guara::ActiveCrm::Scheduled::Deal'

    sign_in user
  end

  given(:group) { Factory(:scheduled_group) }
  given(:list_customers) { (1..3).collect { Factory(:customer_pj, total_employes: 100).customer } }
  given(:customer) { Factory(:customer_pj, total_employes: 100).customer }
  given(:customer_contact) { Factory(:contact, customer: customer) }
  given(:deal) { Factory(:scheduled_group_deals, customer: customer) }

  scenario "contacting a customer" do
      background do
        total_customers = list_customers.size
        @selected_customer = customer
        @selected_group = group
        visit guara.scheduled_scheduled_group_scheduled_contacts_path(@selected_group.scheduled, @selected_group)
      end

      scenario "success contacting with positive result" do
        within("#session") do
          fill_in 'Login', :with => 'user@example.com'
          fill_in 'Password', :with => 'caplin'
        end

      end

  end

end
