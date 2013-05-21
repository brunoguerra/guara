
module Guara
  class FeedbacksController < BaseController
  	load_and_authorize_resource :customer, :class => Guara::Customer
    load_and_authorize_resource :class => Guara::Task
    load_and_authorize_resource :through => :task, :class => Guara::TaskFeedback, :except => [:create, :update]

  	def edit
  		@feedback = TaskFeedback.find(params[:id])
  		render :partial => "guara/task_feedbacks/form_feedback"
  	end  

  	def update
  		@task_feedback = TaskFeedback.find(params[:id])
  		respond_to do |format|
        if @task_feedback.update_attributes(params[:task_feedback])
        	data = @task_feedback.attributes
        	data["resolution_name"] = @task_feedback.resolution.name
          format.json { render :json => {:success=> true, :data=> data } }
        else
          format.json { render :json => {:success=> false, :data=> @task_feedback.errors } }
        end
      end
  	end
  
  end
end