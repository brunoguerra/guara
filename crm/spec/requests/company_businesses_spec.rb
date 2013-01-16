require 'spec_helper'

describe "CompanyBusinesses" do
  describe "GET /company_businesses" do
    it "works! (now write some real specs)" do
      #Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get company_businesses_path
      response.status.should be(302)
    end
  end
end
