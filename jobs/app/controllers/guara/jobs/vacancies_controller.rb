
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
        end

        #raise param_search.to_yaml
        @search = Vacancy.search(param_search)

        if class_exists?("Ransack")
            @vacancy = @search.result().paginate(page: params[:page], :per_page => 10)
        else
            @vacancy = @search.paginate(page: params[:page], :per_page => 10)
        end
      end

    end
  end
end