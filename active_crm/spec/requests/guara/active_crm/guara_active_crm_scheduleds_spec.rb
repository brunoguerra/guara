require 'spec_helper'

describe "ActiveCrm::Scheduleds" do
  describe "GET /guara_active_crm_scheduleds" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get guara_active_crm_Scheduleds_path
      response.status.should be(200)
    end
  end
end
