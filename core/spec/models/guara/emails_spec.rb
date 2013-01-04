require 'spec_helper'

module Guara
  describe Guara::Email do
  
    before do
      @email = Email.new(email:Faker::Internet.email, 
                         emailable: FactoryGirl.create(:user))
    end
    subject { @email }
  
    it { respond_to :emailable }
    it { respond_to :infos }
    it { respond_to :private }
  
    it { should be_valid }
  
    describe "when emailable is not present" do
      before { @email.emailable_id = nil }
      it { should_not be_valid }
    end
  
  
  
  end
end