require 'spec_helper'

  module Guara
  describe "active_crm/Scheduleds/show" do
    before(:each) do
      @active_crm_Scheduled = assign(:active_crm_Scheduled, stub_model(ActiveCrm::Scheduled,
        :subject => "Subject",
        :task_type => nil,
        :user => nil
      ))
    end

    it "renders attributes in <p>" do
      render
      # Run the generator again with the --webrat flag if you want to use webrat matchers
      rendered.should match(/Subject/)
      rendered.should match(//)
      rendered.should match(//)
    end
  end
end