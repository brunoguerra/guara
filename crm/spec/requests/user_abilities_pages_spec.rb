require 'spec_helper'

include UserAbilitiesHelper

describe "User Abilities Pages" do
  
  subject { page }
  
  let (:admin) { FactoryGirl.create(:admin) }
  let (:user) { FactoryGirl.create(:user) }
  
  before do
    sign_out
    sign_in admin
  end
  
  describe "access link to edit user privilegies in show user page" do
    before do
      visit user_path(user)
    end    
  
    it { should have_link(I18n.t("users.abilities.link")) }
    
    describe "when click, go to user abilities pages" do
      before { click_link I18n.t("users.abilities.link") }
      it { should have_selector("h1", text: I18n.t("users.abilities.title", :user => user.name)) }
      it { should on_path(user_abilities_path(user)) }
    end
    
  end
  
  describe "edit multiple abilities and modules on index page " do
    before do
       able(user, :read,   "customer")
       able(user, :update, "contact")
       visit user_abilities_path(user)
    end
      
    it { should have_content(I18n.t("users.abilities.title", :user => user.name)) }
    
    it { should have_content(I18n.t("system.modules.%s" % SystemModule.USER.name.downcase)) }
    
    it { find(:id, abilities_id_checkbox(SystemModule.CUSTOMER, SystemAbility.READ)).should be_checked }
    
    it { find(:id, abilities_id_checkbox(SystemModule.CONTACT, SystemAbility.UPDATE)).should be_checked }
          
    it { should have_selector("input", value: I18n.t("helpers.forms.update")) }


    describe "add ability to User to Update Customer" do
      before do
        check abilities_id_checkbox(SystemModule.CUSTOMER, SystemAbility.CREATE)
      end
      
      it "add ability to user when check item" do
        expect { click_on I18n.t("helpers.forms.update") }.to change(UserAbility, :count).by(+1)
      end
    end
    
    describe "add ability to User to Update Customer" do
      before do
        check abilities_id_checkbox(SystemModule.CUSTOMER, SystemAbility.CREATE)
        check abilities_id_checkbox(SystemModule.CUSTOMER, SystemAbility.UPDATE)
        click_on I18n.t("helpers.forms.update")
      end
      
      it { user.able?(SystemModule.CUSTOMER, SystemAbility.CREATE).should be_true }
      it { user.able?(SystemModule.CUSTOMER, SystemAbility.UPDATE).should be_true }
      
    end
  end
  
end