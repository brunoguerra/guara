module Guara
  module Jobs
    class SchedulerProfessionalsController < BaseController
      load_and_authorize_resource :vacancy, :class => "Guara::Jobs::Vacancy"
      load_and_authorize_resource :scheduling, through: :vacancy, :class => "Guara::Jobs::VacancySchedulingProfessional"
      include ::Guara::Jobs::ActiveProcess::ProcessStepComponent
      
      def initialize()
        @widget_request = true
      end
      
      def load_selecteds_professionals()
        @vacancy      = @vacancy || Vacancy.find_by_process_instance_id(params[:process_instance_id])
        
        @unscheduleds = VacancySchedulingProfessional.unscheduled_professionals(@vacancy)
        @scheduleds   = VacancySchedulingProfessional.scheduled_professionals(@vacancy)
      end
      
      def index
        load_selecteds_professionals()
        
        if @widget_request
          render :partial => "guara/jobs/scheduler_professionals/widget_index", :locals => { vacancy: @vacancy}
        else        
          respond_to do |format|
            format.html { render :index }
            format.json { render json: [@unscheduled_professionals, @scheduled_professionals] }
          end
        end
      end
      
      def show()
        
      end
      
      def new()
        @vacancy_scheduling = VacancySchedulingProfessional.new
        if @widget_request
          render :partial => "guara/jobs/scheduler_professionals/widget_new", :locals => { vacancy: @vacancy}
        else
          render
        end
      end
      
      def create()
        
      end
      
      def edit()
        
      end
      
      def update()
        
      end
         
    end
    
  end
end