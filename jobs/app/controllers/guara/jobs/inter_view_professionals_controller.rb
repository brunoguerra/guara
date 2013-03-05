module Guara
  module Jobs
    class InterViewProfessionalsController < BaseController
    	load_and_authorize_resource :vacancy, :class => "Guara::Jobs::Vacancy"
      	load_and_authorize_resource :scheduling, through: :vacancy, :class => "Guara::Jobs::VacancySchedulingProfessional"
      	include ::Guara::Jobs::ActiveProcess::ProcessStepComponent

        include ProcessInstanceHelper

      	def initialize
	        @widget_request = true
	    end
	      
	    def load_selecteds_professionals
	        @vacancy      = @vacancy || Vacancy.find_by_process_instance_id(params[:process_instance_id])
	        @inter_view_professionals = VacancySchedulingProfessional.where(vacancy_id: @vacancy.id)
	    end

      def show
        
      end

    	def index
    		load_selecteds_professionals
    		render :partial => "guara/jobs/inter_view_professionals/widget_index", :locals => { vacancy: @vacancy}
    	end

    	def edit
    		@vacancy_scheduling = VacancySchedulingProfessional.find(:first, :conditions=> ['vacancy_id = ? AND professional_id = ?', params[:vacancy_id], params[:professional_id]])
	        if @widget_request
	          render :partial => "guara/jobs/inter_view_professionals/widget_edit", :locals => { vacancy: @vacancy}
	        else
	          render
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


    end
  end
end  
