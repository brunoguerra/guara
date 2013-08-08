require 'spec_helper'

describe "active_crm/Scheduleds/new" do
  before(:each) do
    assign(:active_crm_Scheduled, stub_model(ActiveCrm::Scheduled,
      :subject => "MyString",
      :task_type => nil,
      :user => nil
    ).as_new_record)
  end

  it "renders new active_crm_Scheduled form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => active_crm_Scheduleds_path, :method => "post" do
      assert_select "input#active_crm_Scheduled_subject", :name => "active_crm_Scheduled[subject]"
      assert_select "input#active_crm_Scheduled_task_type", :name => "active_crm_Scheduled[task_type]"
      assert_select "input#active_crm_Scheduled_user", :name => "active_crm_Scheduled[user]"
    end
  end
end
