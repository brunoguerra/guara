require 'spec_helper'

module Guara
  describe CompanyBranch do
    
    before do
      @branch = CompanyBranch.new
    end
    
    it { should be_valid }
    
    it { should respond_to(:name) }
    it { should respond_to(:address) }
    it { should respond_to(:enabled) }
    
    it "has one address" do
      @branch.build_address
      @branch.address.should be_valid
    end
    
  end
end
