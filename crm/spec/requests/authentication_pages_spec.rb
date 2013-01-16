require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit new_user_session_path }

    it { should have_selector('h1',    text: I18n.t("sign.in.title")) }
    it { should have_selector('title', text: I18n.t("sign.in.title")) }
  end
  
  describe "signin" do
    before { visit new_user_session_path }

    describe "with invalid information" do
        before do
          fill_in I18n.t("session.email"),    with: "invalid@email.com"
          fill_in I18n.t("session.password"), with: "invalid_password"
          click_button I18n.t("sign.in.link")
          #puts page.body.to_yaml
        end

        it { should have_selector('title', text: I18n.t("sign.in.title")) }
        it { should have_selector('div.alert', text: I18n.t("devise.failure.invalid")) }

        describe "after visiting another page" do
          before { click_link I18n.t("home.link") }
          it { should_not have_selector('div.alert.alert-error') }
        end
      end
    
      describe "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
        before { sign_in user }

        it { should have_selector('h1', text: user.name) }

        it { should have_link(I18n.t('customers.link'),    href: customers_path) }
        it { should have_link(I18n.t('users.profile.link'),  href: user_path(user)) }
        it { should have_link(I18n.t('users.settings.link'), href: edit_user_path(user)) }
        it { should have_link(I18n.t('sign.out.link'), href: destroy_user_session_path) }

        it { should_not have_link(I18n.t('sign.in.link'), href: new_user_session_path) }
        
        describe "followed by signout" do
          #click_link I18n.t("sign.out.link")
          before { visit destroy_user_session_path }
          it { should have_link(I18n.t("sign.in.link")) }
        end
      end
  end
  
  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          #expect { visit edit_user_path(user) }.to raise_error(CanCan::AccessDenied)
          visit edit_user_path(user)
        end
        
        describe "redirected to root with alert" do
          it { should have_selector('div.alert', text: I18n.t('session.erros.restrict_redirected')) }
          it { should have_selector('title', text: I18n.t('sign.in.title')) }
        end

        describe " and signing in" do
          
          before do
             able_update(user, SystemModule.USER)
             able(user, :read, :task)
             able(user, :update, :task)
             sign_in user
             visit edit_user_path(user)
          end
          
          it "should render the desired protected page" do
            
            page.should have_selector('title', text: I18n.t('users.edit.title'))
          end
        end
      end
      
      describe "in the Users controller" do

        describe "visiting the edit page" do
          before do
             able_read(user, SystemModule.USER)
             visit edit_user_path(user)
          end
          it { should have_selector('title', text: I18n.t('sign.in.title')) }
        end

        describe "submitting to the update action" do
          before do
             visit edit_user_path(user)
          end
          specify { current_path.should_not be(edit_user_path(user)) }
        end
        
        describe "visiting the user index" do
            before { visit users_path }
            it { should have_selector('title', text: I18n.t('sign.in.title')) }
          end
      end
      
      describe "in the Microposts controller" do

        describe "submitting to the create action" do
          before { post microposts_path }
          specify { response.should redirect_to(new_user_session_path) }
        end

        describe "submitting to the destroy action" do
          before { delete micropost_path(FactoryGirl.create(:micropost)) }
          specify { response.should redirect_to(new_user_session_path) }
        end
      end
      
    end
  
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, name: "BLA BLA", email: "wrong@example.com") }
      before { sign_in user }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: full_title(I18n.t('users.edit.title'))) }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end
    
    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(root_path) }        
      end
    end
    
  end
  
  
end