require 'spec_helper'

describe "active_crm/scheculeds/index" do
  before(:each) do
    assign(:active_crm_scheculeds, [
      stub_model(ActiveCrm::Scheculed,
        :subject => "Subject",
        :task_type => nil,
        :user => nil
      ),
      stub_model(ActiveCrm::Scheculed,
        :subject => "Subject",
        :task_type => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of active_crm/scheculeds" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
