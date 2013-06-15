module Guara
	module Jobs
		class VacancyResumeController < Guara::BaseController
			load_and_authorize_resource class: "Guara::Jobs::Vacancy"
			include Select2Helper

			def index
				params[:search] = {} if params[:search].nil?
				params[:resume_type] = 1 if params[:resume_type].nil? 

				param_search = params[:search]
	          	filter_multiselect param_search, :role_id_in
	          	filter_multiselect param_search, :status_id_in
	          	filter_multiselect param_search, :consultant_id_in

		        @search = Vacancy.resume_type(params[:resume_type].to_i).search(param_search)

		        @search2 = Vacancy.search(param_search)

		        if class_exists?("Ransack")
		            @vacancy = @search.result().count()
		            @vacancy2 = @search2.result().count()
		        else
		            @vacancy = @search.count()
		            @vacancy2 = @search2.count()
		        end
		        @vacancies_resume = true
			end




		end
	end
end