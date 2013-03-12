module Guara
  module Jobs
    class InterviewerProfessionalsController < BaseController
    	load_and_authorize_resource :vacancy, :class => "Guara::Jobs::Vacancy"
      	load_and_authorize_resource :scheduling, through: :vacancy, :class => "Guara::Jobs::VacancySchedulingProfessional"
      	include ::Guara::Jobs::ActiveProcess::ProcessStepComponent
        include ProcessInstanceHelper

      def initialize
	        @widget_request = true
	    end
	      
	    def load_selecteds_professionals
	        @vacancy      = @vacancy || Vacancy.find_by_process_instance_id(params[:process_instance_id])
	        @interviewer_professionals = VacancySchedulingProfessional.where(vacancy_id: @vacancy.id)
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
    		@scheduling = VacancySchedulingProfessional.find(:first, :conditions=> ['vacancy_id = ? AND professional_id = ?', params[:vacancy_id], params[:professional_id]])
        
        @step = @step || Guara::Jobs::Step.find(params[:edit_step])

        @interview = VacancyProfessionalsInterview.find_by_scheduling_id(@scheduling.id) ||
                      VacancyProfessionalsInterview.create(scheduling_id: @scheduling.id, vacancy_step_id: @step.id)

        
        initialize_interview()

        @interview_process_instance = @interview.interview_process_instance

        if @widget_request
          render :partial => "guara/jobs/interviewer_professionals/widget_edit", :locals => { vacancy: @vacancy, embedded: edit_embeded_process()}
        else
          render
        end
    	end

      def initialize_interview
        unless @interview.interview_process_instance
          @custom_process = VacancyProfessionalsInterview.custom_process
          
          @interview.interview_process_instance = ProcessInstance.create({
            :process_id=> @custom_process.id,
            :date_start=> Time.now.to_s(:db),
            :user_using_process=> current_user.id,
            :state=> @custom_process.step_init
          })  
        end
      end

      def update
          @a = params[:jobs_vacancy_scheduling_professional]
          @vacancy_scheduling = VacancySchedulingProfessional.find(:first, :conditions=> ['vacancy_id = ? AND professional_id = ?', @a[:vacancy_id], @a[:professional_id]])
          @vacancy_scheduling.update_attributes(@a)
          if @vacancy_scheduling
            render :json => {:success=> true}
          else
            render :json => {:data=> @vacancy_scheduling.errors, :success=> false} 
          end
      end


      def edit_embeded_process()
          ProcessInstanceController.new.embeded_call(:edit, @interview.interview_process_instance, params, request, response)
      end


    end
  end
end  
