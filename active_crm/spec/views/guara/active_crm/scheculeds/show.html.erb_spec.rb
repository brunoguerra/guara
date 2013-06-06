require 'spec_helper'

describe "active_crm/scheculeds/show" do
  before(:each) do
    @active_crm_scheculed = assign(:active_crm_scheculed, stub_model(ActiveCrm::Scheculed,
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
