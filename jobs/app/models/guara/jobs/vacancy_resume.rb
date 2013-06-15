module Guara
	module Jobs
		class VacancyResume < ActiveRecord::Base
			
			def self.type
				{
					1 => :number_of_jobs_posted_within,
					2 => :number_of_clients_open,
					3 => :amount_of_vacancy_that_was_accepted_candidates_to_the_client,
					4 => :number_of_jobs_that_were_rework_re_selection
				}
			end

			def self.type_translated
				{
					1 => I18n.t("jobs.vacancy_reports.number_of_jobs_posted_within"),
					2 => I18n.t("jobs.vacancy_reports.number_of_clients_open"),
					3 => I18n.t("jobs.vacancy_reports.amount_of_vacancy_that_was_accepted_candidates_to_the_client"),
					4 => I18n.t("jobs.vacancy_reports.number_of_jobs_that_were_rework_re_selection")
				}
			end
			  	
		end
	end
end
