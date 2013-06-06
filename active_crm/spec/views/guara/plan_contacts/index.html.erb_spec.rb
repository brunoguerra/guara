require 'spec_helper'

describe "plan_contacts/index" do
  before(:each) do
    assign(:plan_contacts, [
      stub_model(PlanContact,
        :subject => "Subject",
        :task_type => nil,
        :user => nil
      ),
      stub_model(PlanContact,
        :subject => "Subject",
        :task_type => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of plan_contacts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
