
module Guara
  module Jobs
    class VacancySchedulerController < BaseController
      
      def index
        @vacancy = Vacancy.find_by_process_instance params[:process_instance_id]
        @unscheduled_professionals = @vacancy.unscheduled_professionals()
        @scheduled_professionals = @vacancy.scheduled_professionals()
        
        respond_to do |format|
          format.html { render :index }
          format.json { render json: [@unscheduled_professionals, @scheduled_professionals] }
        end
      end
    end
    
  end
end