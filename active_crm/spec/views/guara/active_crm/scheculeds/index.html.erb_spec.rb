require 'spec_helper'

describe "active_crm/Scheduleds/index" do
  before(:each) do
    assign(:active_crm_Scheduleds, [
      stub_model(ActiveCrm::Scheduled,
        :subject => "Subject",
        :task_type => nil,
        :user => nil
      ),
      stub_model(ActiveCrm::Scheduled,
        :subject => "Subject",
        :task_type => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of active_crm/Scheduleds" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
