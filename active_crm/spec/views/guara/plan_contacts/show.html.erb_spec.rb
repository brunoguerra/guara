require 'spec_helper'

describe "plan_contacts/show" do
  before(:each) do
    @plan_contact = assign(:plan_contact, stub_model(PlanContact,
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
