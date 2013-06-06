require 'spec_helper'

describe "plan_contacts/new" do
  before(:each) do
    assign(:plan_contact, stub_model(PlanContact,
      :subject => "MyString",
      :task_type => nil,
      :user => nil
    ).as_new_record)
  end

  it "renders new plan_contact form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => plan_contacts_path, :method => "post" do
      assert_select "input#plan_contact_subject", :name => "plan_contact[subject]"
      assert_select "input#plan_contact_task_type", :name => "plan_contact[task_type]"
      assert_select "input#plan_contact_user", :name => "plan_contact[user]"
    end
  end
end
