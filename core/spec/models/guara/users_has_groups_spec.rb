require 'spec_helper'

describe Guara::UsersHasGroups do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:group) { FactoryGirl.create(:user_group) }
  let(:groups) { user.users_has_groups.build(user_group_id: group.id) }

  subject { groups }
  it { should respond_to(:user) }    
  it { should respond_to(:user_group) }
  it { should be_valid }
  
  describe "grouping methods" do    
     its(:user) { should == user }
     its(:user_group) { should == group }
   end

   describe "when user id is not present" do
     before { groups.user_id = nil }
     it { should_not be_valid }
   end

   describe "when follower id is not present" do
     before { groups.user_group_id = nil }
     it { should_not be_valid }
   end
  
end
