require 'spec_helper'

describe "ActiveCrm::Scheculeds" do
  describe "GET /guara_active_crm_scheculeds" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get guara_active_crm_scheculeds_path
      response.status.should be(200)
    end
  end
end
