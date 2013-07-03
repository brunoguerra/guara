require 'spec_helper'

module Guara

describe "User pages" do

  subject { page }
  
  describe "index" do

    let(:user) { FactoryGirl.build(:user) }

    before(:all) { 30.times { FactoryGirl.create(:user) } }
    after(:all)  { User.delete_all }

    before(:each) do    
      able(user, "read", "user")
      able(user, "create", "user")
      sign_in user
      visit users_path
    end

    it "elements basic" do
      should have_selector('title', text: I18n.t('users.index.title'))
      should have_selector('a.brand', text: I18n.t('users.index.title'))
    end

    describe "pagination" do

      it "should list group of each user" do
        should have_selector('div.pagination')

        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end
    
    
    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_out
          sign_in admin
          visit users_path
          bt_disable = "a[href=#{destroy_user_path(User.first)}]"
        end
        
        it { should have_css(bt_disable) }
        it "should be able to delete another user" do
          expect { find(bt_disable).click() }.to change(User, :count).by(-1)
        end
        it { should_not have_css("a[href=#{destroy_user_path(admin)}]") }
      end
    end 
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }

    before do
       able_update(user, SystemModule.USER)
       able_create(user, SystemModule.USER)
       sign_in user
       visit user_path(user);
    end

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }

    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end
  end
  
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      able_update(user, SystemModule.USER)
      able_create(user, SystemModule.USER)
      #login_as(user, :scope => :user)
      sign_in user

      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1',    text: I18n.t("users.edit.title")) }
      it { should have_selector('title', text: I18n.t("users.edit.title")) }
      # review it { should have_link(I18n.t('user.profile.change'), href: 'http://gravatar.com/emails') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in I18n.t("users.name"),             with: new_name
        fill_in I18n.t("users.email"),            with: new_email
        fill_in I18n.t("users.password"),         with: user.password
        fill_in I18n.t("users.password_confirmation"), with: user.password
        click_button autotitle_update("User")
        user.reload
        
        visit user_path(user)
      end

      it { should have_selector('title', text: new_name) }
      it { should have_link(I18n.t("sign.out.link"), href: destroy_user_session_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end
    
    context "company branch" do
      
      let(:company_branch) { Factory(:company_branch) }

      before do
        
        @primary_company_branch = company_branch
        user.primary_company_branch = nil
        #refresh page
        visit edit_user_path(user)
        user.save
      end

      after do
        sign_out
      end
      
      it "should editing with first user wiith company branch" do
        select(company_branch.name, :from => I18n.t("users.primary_company_branch"))
        click_button autotitle_update("User") 
        #
        user.reload.primary_company_branch.id.should be(@primary_company_branch.id)
      end
    end
    
    it "" do
      
    end
  end
  
end

end