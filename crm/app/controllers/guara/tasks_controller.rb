module Guara
  class TasksController < BaseController
    load_and_authorize_resource :customer, :class => Guara::Customer
    load_and_authorize_resource :through => :customer, :class => Guara::Task, :except => [:create, :update]
    
    include FormAjaxHelper

    helper CustomersHelper
    helper TasksHelper
    
    def initialize()
      super
      @no_layout = false
    end
  
    def index
      @search = @tasks.search(params[:search])

      if class_exists?("Ransack")
        @tasks = @search.result().paginate(page: params[:page], :per_page => 20)
      else
        @tasks = @search.paginate(page: params[:page], :per_page => 20)
      end

      respond_to do |format|
        format.html { render "index", :layout => "guara/base" }
        format.json do
           render :template => "guara/tasks/_list", :locals => { items: @customer.tasks.paginate(page:params[:task_page] || 1, per_page: 3) }, :formats => :html, :layout => false
        end
        format.js { head :no_content }
      end
    end
  
    def show
    
      @feedbacks = @task.feedbacks
    
      respond_to do |format| 
        format.html #
        format.js { @no_layout = true }
      end
    end
  
    def new
      @task.feedbacks.build
    end
  
    def edit
      @task.feedbacks.build
    end
  
    def load_form
      #remove conficts
      feedback_params = params[:task][:feedbacks]
      params[:task].delete :feedbacks
    
      #not loaded task for incompatibilities
      if params[:id]
        @task = @customer.tasks.find params[:id]
        @task.update_attributes(params[:task])
      else
        @task = @customer.tasks.build(params[:task])
      end
      feedback = @task.feedbacks.build(feedback_params)
    
      @task.status = SystemTaskStatus.OPENED
      @task.user = current_user
      
      if feedback.notes.to_s.empty? && feedback.resolution.nil?
        @task.feedbacks.delete feedback
      else
        #filled feedback?
        if (!feedback.resolution.nil?)
          if @task.feedbacks[0].valid?
            #TODO: Business Rule. Put in model
            @task.resolution = feedback.resolution
            
            if !@task.resolution.task_status_change.nil?
              @task.status = @task.resolution.task_status_change
            end
            @task.finish_time = Time.now
          else
            if (@task.feedbacks[0].resolution.nil? && @task.feedbacks[0].notes.empty?)
              @task.feedbacks.delete(@task.feedbacks[0])
            end
          end
        end
      end
    end
  
    def create
      load_form
    
      respond_to do |format|
        if @task.save
          format.js { render :locals => { :task => @task }, :layout => false, :content_type => "application/javascript", :status => :created }
          format.html { redirect_to customer_task_path(@task.interested, @task) }
        else
          format.js { render :json => format_errors("tasks", @task.errors), :content_type => "application/json", :status => :unprocessable_entity }
          format.html { render :action => :new, :status => :unprocessable_entity }
        end
      end
    end
  
    def update
      load_form
    
    
      respond_to do |format|
      
        if @task.update_attributes(params[:task])
          format.html { redirect_to( customer_task_path(@task.interested, @task), :notice => I18n.t('forms.update.sucess')) }
          format.json { head :ok }
        else
          format.html { render :action => "edit" }
          format.json { render :json => @task.errors, :status => :unprocessable_entity }
        end
      end
    end
  
  end
end