require 'spec_helper'

describe "Tests::Ajaxes" do
  describe "GET /tests_ajaxes" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get tests_ajaxes_path
      response.status.should be(302)
    end
  end
end
