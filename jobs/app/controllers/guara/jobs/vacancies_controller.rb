
module Guara
  module Jobs
    class VacanciesController < BaseController
      
      def change_status
        @process_instance = @ProcessInstance.find params[:process_instance_id]
        @vancancy = Vacancy.find_by_process_instance_id @process_instance.id
        status_to_change = VacancyStatus.enum[params[:status]]
        @vacancy.change_status status_to_change
        redirect_to @process_instance
      end
      
    end
  end
end