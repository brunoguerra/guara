require 'spec_helper'

module Guara
  describe UserGroup do

    before do
      @users_group = UserGroup.new( name: "Operators" )
    end
  
    subject { @users_group }
  
    it { should respond_to :name }
    it { should respond_to :abilities }
    it { should be_valid }
  
    describe "Have abilities" do
      before do      
        @user_abillity_1 = @users_group.abilities.build(:ability => SystemAbility.READ,   :module => SystemModule.CITY)
        @user_abillity_2 = @users_group.abilities.build(:ability => SystemAbility.CREATE, :module => SystemModule.CITY)
      end
      it { should be_valid }
    
      its (:abilities) { should == [@user_abillity_1, @user_abillity_2] }
    
    end

  end
end