require 'spec_helper'

include UserAbilitiesHelper
include LocaleHelper

describe "Customer Task Pages" do
  
  subject { page }
  let(:times) { 0 }
  let (:admin) { Factory(:admin) }
  let!(:user) { Factory(:user) }
  let!(:customer_pj) { Factory(:customer_pj) }
  let!(:contact) { Factory(:contact, customer: customer_pj.customer) }
  let!(:task) { Factory(:task, user: user, interested: customer_pj.customer ) }
  
  before do
    #rights
    able(user, :read,  :customer)
    able(user, :read,  :customer_pj)
    able(user, :read,  :contact)
    able(user, :read,  :user)
    able(user, :read,  :task)
    able(user, :create, :task)
  end

  describe "side panel with history of tasks" do
    before do
      #sign_in
      #TODO: testar user abilities
      #sign_in user
      sign_in admin
      visit customer_path(customer_pj.customer)
    end
    
    it { should have_content(I18n.t("tasks.side.title")) }
    it { should have_content(I18n.t("tasks.new.link")) }
    it { find("div.tasks .new .form").should_not be_visible }    
    
    describe ", only user with rights can see and click in new task" do
      pending("do this rights")
    end
    
    describe ", click on new link on the histories", :js => true do
      before do
        click_on I18n.t("tasks.new.link")
        wait_until_visible("div.tasks .new .form")
      end
      
      it "and panel of new task appears" do
         find("div.tasks .new .form").should be_visible
      end
      
      describe "add valid task" do
        before do
          @task_name = Faker::Name.first_name
          @task_date_str = (Time.now + 2.days).strftime("%d/%m/%Y %H:%m")
          fill_in I18n.t("tasks.name"),      with: @task_name
          fill_in I18n.t("tasks.due_time"),  with: @task_date_str
          select contact.name, from: I18n.t("tasks.contact")
          select user.name, from: I18n.t("tasks.assigned")
          fill_in I18n.t("tasks.notes"),     with: Faker::Lorem.sentence(5)
        end
        
        it "and save the task" do
           expect do
              click_on I18n.t("helpers.forms.save")
              wait_for_response()
           end.to change(Task, :count).by(+1)
        end
        
        describe "add task with feedback" do
          before do
            
            click_on I18n.t("tasks.form.save_with_feedback.title")
            wait_for_animations()
            
            select SystemTaskResolution.RESOLVED.name, from: I18n.t("feedbacks.resolution") + "*"
            fill_in I18n.t("feedbacks.notes"), with: Faker::Lorem.sentence(4)[0..59]
            click_on I18n.t("helpers.forms.save")
            
            wait_for_response()
            wait_for_animations()
          end
          
          it "should save task and add feedback to the task" do
            should have_content(@task_name)
            should have_content(@task_date_str)
          end
          
        end
      end
    end
    
    describe "show last 3 tasks on index" do
      pending("fazer a contagem de tasks")
    end
    
    describe "and Show more details for task", :js => true, :no_driver => :selenium do
      before do
        find("#task%d" % task.id).click()
        wait_for_response
      end
      
      it "should appear um dialog with more explanation of task" do
        visible?(".modal-task").should be_true
        should have_content I18n.t("tasks.show.title", task: name_or_empty(task) )
        should have_content task.name
        should have_content format_datetime(task.due_time)
      end
    end
    
  end
  
  describe "show task" do
    before do
      sign_in admin
      visit customer_task_path(customer_pj.customer, task)
    end
    
    it { should have_content(I18n.t("feedbacks.side.title")) }
    it { pending("test list of feedbacks for task") }
  end

end