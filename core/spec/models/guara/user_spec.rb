# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(25)
#  email      :string(100)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

module Guara

  include UsersHelper

  describe Guara::User do

    before(:all) { clear_test_dummy }

    before do
      @user = User.new(name: "Example User", email: "user@example.com", 
                       password: "foobar", password_confirmation: "foobar")
    end

    subject { @user }
  
    let(:found_user) { User.find_by_email(@user.email)?:found_user:@user }

    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:remember_token) }
  
    it { should respond_to(:microposts) }
    it { should respond_to(:feed) }
  
    #colaboration
    it { should respond_to(:relationships) }
    it { should respond_to(:followed_users) }  
    it { should respond_to(:following?) }
    it { should respond_to(:follow!) }
    it { should respond_to(:followers) }
  
    #groups
    it { should respond_to :groups }
    it { should respond_to :primary_group }
    it { should respond_to :secundary_groups }
    
    it { should respond_to(:admin) }
  
    it { should respond_to(:primary_company_business) }

    it { should be_valid }
    it { should_not be_admin }
  
    it { respond_to :able? }

    describe "when name is not present" do
      before { @user.name = " " }
      it { should_not be_valid }
    end
  
    describe "when email format is invalid" do
      it "should be invalid" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                       foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
          @user.email = invalid_address
          @user.should_not be_valid
        end      
      end
    end 

    describe "when email format is valid" do
      it "should be valid" do
        addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          @user.email = valid_address
          @user.should be_valid
        end      
      end
    end
  
    describe "when email address is already taken" do
        before do
          user_with_same_email = @user.dup
          user_with_same_email.email = @user.email.upcase
          user_with_same_email.save
        end

        it { should_not be_valid }
    end
  
    #PASSWORDS TESTS <================================================
  
    describe "when password is not present" do
      before { @user.password = @user.password_confirmation = " " }
      it { should_not be_valid }
    end

    describe "when password doesn't match confirmation" do
      before { @user.password_confirmation = "mismatch" }
      it { should_not be_valid }
    end

    describe "when password confirmation is nil" do
      before { @user.password_confirmation = nil }
      it { should_not be_valid }
    end

    describe "with a password that's too short" do
      before { @user.password = @user.password_confirmation = "a" * 5 }
      it { should be_invalid }
    end

    describe "email address with mixed case" do
      let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

      it "should be saved as all lower-case" do
        @user.email = mixed_case_email
        @user.save
        @user.reload.email.should == mixed_case_email.downcase
      end
    end

    #AUTHENTICATION <================================================
=begin  
    describe "return value of authenticate method" do
      before { @user.save }
      let(:found_user) { User.find_by_email(@user.email) }

      describe "with valid password" do
        it { should == found_user.authenticate(@user.password) }
      end

      describe "with invalid password" do
        let(:user_for_invalid_password) { found_user.authenticate("invalid") }

        it { should_not == user_for_invalid_password }
        specify { user_for_invalid_password.should be_false }
      end
    end
=end

    #REMEMBER <================================================
  
    describe "remember token" do
      before { @user.save }
      its(:remember_token) { should_not be_blank }
    end
  
  
    #ADMIN <================================================
  
      describe "with admin attribute set to 'true'" do
        before { @user.toggle!(:admin) }
        it { should be_admin }
      
        it "attr admin must be accessible" do
          expect do
            @user.toggle!(:admin)
          end.to_not raise_error(ActiveModel::MassAssignmentSecurity::Error)  
        end
      
      end
    
    #MICROPOSTS <==============================================
  
    describe "micropost associations" do

      before { @user.save }
      let!(:older_micropost) do 
        FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
      end
      let!(:newer_micropost) do
        FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
      end

      it "should have the right microposts in the right order" do
        @user.microposts.should == [newer_micropost, older_micropost]
      end
    
      it "should destroy associated microposts" do
        microposts = @user.microposts
        @user.destroy_fully
        microposts.each do |micropost|
          Micropost.find_by_id(micropost.id).should be_nil
        end
      end
    
      describe "status" do
        let(:unfollowed_post) do
          FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
        end

        its(:feed) { should include(newer_micropost) }
        its(:feed) { should include(older_micropost) }
        its(:feed) { should_not include(unfollowed_post) }
      end
    end
  
    #FOLLOWING<===================================================
  
    describe "following" do
      let(:other_user) { FactoryGirl.create(:user) }    
      before do
        @user.save
        @user.follow!(other_user)
      end

      it { should be_following(other_user) }
      its(:followed_users) { should include(other_user) }
    
      describe "and unfollowing" do
        before { @user.unfollow!(other_user) }

        it { should_not be_following(other_user) }
        its(:followed_users) { should_not include(other_user) }
      end
    
      it { should be_following(other_user) }
      its(:followed_users) { should include(other_user) }

      describe "followed user" do
        subject { other_user }
        its(:followers) { should include(@user) }
      end
    
    end


    #User and Groups<=============================================
  
    describe "have a primary group or not " do
      it(:primary_group) { @user.primary_group = UserGroup.first }
      it { should be_valid }
    end
  
    describe "have many groups" do
      let!(:group_primary) { UserGroup.first }
      let(:group_secs) { [FactoryGirl.create(:user_group), FactoryGirl.create(:user_group)] }
      before do
        @user.save
        @user.primary_group = group_primary
        @user.secundary_groups = group_secs
        @user.save
      end
      it { should be_valid }
      its (:groups) { should include(group_secs[0]) }
      its (:groups) { should include(group_secs[1]) }
    
    end
  

  
    describe "user able?" do
      before do
        able(@user, :create, :city)
        able(@user, :read, :user)
      end
    
      it { @user.able?(SystemModule.CITY, SystemAbility.CREATE).should be_true }
      it { @user.able?(SystemModule.USER, SystemAbility.READ).should be_true }
      it { @user.able?(SystemModule.USER, SystemAbility.CREATE).should_not be_true }
    end
  
  end
end