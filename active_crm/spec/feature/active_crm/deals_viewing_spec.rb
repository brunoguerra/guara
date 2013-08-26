require "spec_helper"
require File.expand_path('../deals_viewing_page_util', __FILE__)


feature "Deals Viewing on Plan", %{
  As a Remote Seller, Operation Supervisor on Service Company
  I want to see details of deals at moment, with status, contacts and activity history
  In order to mensure results on direct interaction by service
  } do

  #group target
  given(:group)                { Factory(:scheduled_group) }
  given(:deal)                 { Factory(:scheduled_deals, group: group) }
  given(:contacted_customer)  { Factory :scheduled_contact, deal: deal }

  background do
    @user = FactoryGirl.create(:user)
    make_user_abilities
    sign_in @user
  end

  #page objects
  given(:deals_viewing_page)   { Guara::ActiveCrm::DealsViewingPageUtil.new(page, group, @user) } #the directors show
  given(:deal_on_page)  { deals_viewing_page.deal_on_page(customer) } #the supporting show

  scenario "" do
    contacted_customer # pre-data
    deals_viewing_page.show
    deal_on_page.click
    expect(deal_on_page).to be_visible
  end

  

  # ==================================================================
  #user accssebilty
  def make_user_abilities
    able @user, :read, 'customer'
    able @user, :read, 'contact'
    able @user, [:read, :create, :update, :delete], 'Guara::ActiveCrm::Scheduled'
    able @user, [:read, :create, :update, :delete], 'Guara::ActiveCrm::Scheduled::CustomerGroup'
    able @user, [:read, :create, :update, :delete], 'Guara::ActiveCrm::Scheduled::Contact'
    able @user, :read, 'Guara::ActiveCrm::Scheduled::Deal'
  end

end