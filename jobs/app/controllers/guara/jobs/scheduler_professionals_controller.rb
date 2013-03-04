
module Guara
  module Jobs
    class SchedulerProfessionalsController < BaseController
      load_and_authorize_resource :vacancy, :class => "Guara::Jobs::Vacancy"
      load_and_authorize_resource :schedulers, through: :vacancy, :class => "Guara::Jobs::VacancySchedulingProfessional"
      include ActiveProcess::ProcessStepComponent
      
      def initialize()
        @widget_request = true
      end
      
      def load_selecteds_professionals()
        @vacancy = @vacancy || Vacancy.find_by_process_instance(params[:process_instance_id])
        @unscheduleds = @vacancy.unscheduled_professionals()
        @scheduleds = @vacancy.scheduled_professionals()
      end
      
      def index
        load_selecteds_professionals()
        
        if @widget_request
          render :partial => "guara/jobs/scheduler_professionals/widget_index"
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
        load_selecteds_professionals()
        if @widget_request
          render :partial => "guara/jobs/scheduler_professionals/widget_new"
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