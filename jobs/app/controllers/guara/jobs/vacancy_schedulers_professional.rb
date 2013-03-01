
module Guara
  module Jobs
    class VacancySchedulersController < BaseController
      
      include ActiveProcess::ProcessStepComponent
      
      def initialize()
        @widget_request = true
      end
      
      def load_selecteds_professionals()
        @vacancy = Vacancy.find_by_process_instance params[:process_instance_id]
        @unscheduled_professionals = @vacancy.unscheduled_professionals()
        @scheduled_professionals = @vacancy.scheduled_professionals()
      end
      
      def index
        load_selecteds_professionals()
        
        if @widget_request
          render :partial => "guara/jobs/vacancy_scheduler/widget_index"
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
        if @widget_request
          render :partial => "guara/jobs/vacancy_scheduler/widget_new"
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