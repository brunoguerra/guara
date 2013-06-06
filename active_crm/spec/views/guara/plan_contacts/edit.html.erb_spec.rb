require 'spec_helper'

describe "plan_contacts/edit" do
  before(:each) do
    @plan_contact = assign(:plan_contact, stub_model(PlanContact,
      :subject => "MyString",
      :task_type => nil,
      :user => nil
    ))
  end

  it "renders the edit plan_contact form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => plan_contacts_path(@plan_contact), :method => "post" do
      assert_select "input#plan_contact_subject", :name => "plan_contact[subject]"
      assert_select "input#plan_contact_task_type", :name => "plan_contact[task_type]"
      assert_select "input#plan_contact_user", :name => "plan_contact[user]"
    end
  end
end
