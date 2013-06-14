
module Guara
  module Jobs
    class VacanciesController < BaseController
      load_and_authorize_resource class: "Guara::Jobs::Vacancy"
      include Select2Helper
      
      def change_status
        @vacancy = Vacancy.find params[:vacancy_id]
        authorize! :read, @vacancy
        status_to_change = VacancyStatus.enum[params[:status_id].to_i]
        @vacancy.change_status!(status_to_change, current_user)
        redirect_to process_instance_path(@vacancy.process_instance)
      end
      
      def index
        param_search = params[:search]
        if !param_search.nil? && param_search.size>0 
          filter_multiselect param_search, :role_id_in
          filter_multiselect param_search, :status_id_in
          filter_multiselect param_search, :consultant_id_in
          filter_multiselect param_search, :type_id_in
        end

        @search = Vacancy.search(param_search)
        @vacancy = paginate(@search, params[:page])

        respond_to do |format|
          format.html do
            #
          end
          format.pdf do
            render  :pdf => "vacancy_reports.pdf", 
                    :template => 'guara/jobs/vacancies/index',
                    :margin => {:top     => 0}, 
                    :lowquality                     => true,
          end
        end
      end

    end # end class
  end
end