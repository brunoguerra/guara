module Guara
  	module Jobs
    	class ProfessionalsSynthesisController < BaseController
    		load_and_authorize_resource :vacancy, :class => "Guara::Jobs::Vacancy"
	    	load_and_authorize_resource :interview, :class => "Guara::Jobs::VacancyProfessionalsInterview"
	    	include ::Guara::Jobs::ActiveProcess::ProcessStepComponent
	      	helper ProcessInstanceHelper
	      	
	      	def index
	      		load_interviews_professionals()
    			render :partial => "guara/jobs/professionals_synthesis/widget_index", :locals => { vacancy: @vacancy}
    	  	end

	      	def load_interviews_professionals
		    	@vacancy = @vacancy || Vacancy.find_by_process_instance_id(params[:process_instance_id])
		        @interviewer_professionals = VacancySchedulingProfessional
		        	.joins(:interview)
		        	.select('guara_jobs_vacancy_scheduling_professionals.*, guara_jobs_vacancy_professionals_interviews.synthesis, guara_jobs_vacancy_professionals_interviews.id as id2')
		        	.where(vacancy_id: @vacancy.id, interested: true)
		    end

		    def load_vacancy_professionals_interview(professional_interview_id)
		        @professional_interview = VacancyProfessionalsInterview.find_by_scheduling_id(professional_interview_id)
		    end

		    def show
		    	load_interviews_professionals
		    	render :partial => "guara/jobs/professionals_synthesis/widget_show"
		    end

		    def edit
		    	@interviewer_professional = VacancyProfessionalsInterview.find_by_scheduling_id(params[:scheduling_id])
		    	
		    	render :partial => "guara/jobs/professionals_synthesis/widget_edit", 
	    				:locals => { :vacancy=> @vacancy, :interviewer_professional=> @interviewer_professional }
	    	end

	    	def update
	    		@a = params[:jobs_vacancy_professionals_interview]
		        @interviewer_professional = VacancyProfessionalsInterview.find(@a[:id])
		          
		        if @interviewer_professional.update_attribute(:synthesis, @a[:synthesis])
		            render :json => {:success=> true}
		        else
		            render :json => {:data=> @interviewer_professional.errors, :success=> false} 
		        end
	    	end

    	end
    end
end
