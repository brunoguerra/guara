module Guara
	module Jobs
		class VacancyProfessionalsPsychologicalEvaluation < ActiveRecord::Base
	    	attr_accessible :date_evaluation, :date_send_report, :path_documents, 
	    	:vacancy_customer_interview_id, :vacancy_scheduling_professional_id, 
	    	:file1, :file2, :file3

	    	belongs_to :vacancy_customer_interview
	    	belongs_to :scheduling, :class_name=> "Guara::Jobs::VacancySchedulingProfessional", :foreign_key=> :vacancy_scheduling_professional_id
	    	has_one :vacancy_final_result
	  	end
	end
end
