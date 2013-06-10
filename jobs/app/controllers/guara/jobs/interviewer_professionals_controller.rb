module Guara
  module Jobs
    class InterviewerProfessionalsController < BaseController
    	load_and_authorize_resource :vacancy, :class => "Guara::Jobs::Vacancy"
    	#load_and_authorize_resource :scheduling, through: :vacancy, :class => "Guara::Jobs::VacancySchedulingProfessional"
    	include ::Guara::Jobs::ActiveProcess::ProcessStepComponent
      include ProcessInstanceHelper
      include FormAjaxHelper


      def initialize
	        @widget_request = true
	    end
	      
	    def load_selecteds_professionals
	        @vacancy      = @vacancy || Vacancy.find_by_process_instance_id(params[:process_instance_id])
	        @interviewer_professionals = VacancySchedulingProfessional.where(vacancy_id: @vacancy.id, interested: true) 
	    end

      def show
        load_selecteds_professionals
        render :partial => "guara/jobs/interviewer_professionals/widget_show"
      end

    	def index
    		load_selecteds_professionals
    		render :partial => "guara/jobs/interviewer_professionals/widget_index", :locals => { vacancy: @vacancy}
    	end

    	def edit
    		load_vacancy_professionals_interview(params[:vacancy_id], params[:professional_id], params[:edit_step])
        initialize_interview()

        @interview_process_instance = @interview.interview_process_instance

        if @widget_request
          render :partial => "guara/jobs/interviewer_professionals/widget_edit", :locals => { vacancy: @vacancy, embedded: form_ajax(:embedded_process_form, edit_embeded_process().join("").html_safe, "")}
        else
          render
        end
    	end

      def initialize_interview
        unless @interview.interview_process_instance
          @custom_process = VacancyProfessionalsInterview.custom_process
          
          @process = ProcessInstance.create({
            :process_id=> @custom_process.id,
            :date_start=> Time.now.to_s(:db),
            :finished=> false,
            :user_using_process=> current_user.id,
            :state=> @custom_process.step_init
          })  

          @interview.update_attributes :interview_process_instance_id=> @process.id
          @interview.save
        end
      end

      def load_vacancy_professionals_interview(vacancy_id, professional_id, step_id)
        @scheduling = VacancySchedulingProfessional.find(:first, :conditions=> ['vacancy_id = ? AND professional_id = ?', vacancy_id, professional_id])
        @step = @step || Guara::Jobs::Step.find(step_id)
        @interview = VacancyProfessionalsInterview.find_by_scheduling_id(@scheduling.id) ||
                      VacancyProfessionalsInterview.create(scheduling_id: @scheduling.id, vacancy_step_id: @step.id)
      end

      def update
          @a = params[:jobs_vacancy_scheduling_professional]
          load_vacancy_professionals_interview(@a[:vacancy_id], @a[:professional_id], params[:step_instance_attrs][:step_id])
          initialize_interview()
          @scheduling.update_attributes(@a)
          
          if @scheduling
            update_embeded_process()
            render :json => {:success=> true}
          else
            render :json => {:data=> @vacancy_scheduling.errors, :success=> false} 
          end
      end

      def edit_embeded_process()
        ProcessInstanceController.new.embeded_call(:edit, @interview.interview_process_instance, params, request, response)
      end

      def show_embeded_process()
        load_vacancy_professionals_interview(params[:vacancy_id], params[:professional_id], params[:edit_step])
        @show_embeded_process = ProcessInstanceController.new.embeded_call(:show, @interview.interview_process_instance, params, request, response)
      end

      def update_embeded_process()
          ProcessInstanceController.new.embeded_call(:update, @interview.interview_process_instance, params, request, response)
      end

    end
  end
end  
