require 'spec_helper'

describe "active_crm/scheculeds/new" do
  before(:each) do
    assign(:active_crm_scheculed, stub_model(ActiveCrm::Scheculed,
      :subject => "MyString",
      :task_type => nil,
      :user => nil
    ).as_new_record)
  end

  it "renders new active_crm_scheculed form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => active_crm_scheculeds_path, :method => "post" do
      assert_select "input#active_crm_scheculed_subject", :name => "active_crm_scheculed[subject]"
      assert_select "input#active_crm_scheculed_task_type", :name => "active_crm_scheculed[task_type]"
      assert_select "input#active_crm_scheculed_user", :name => "active_crm_scheculed[user]"
    end
  end
end
