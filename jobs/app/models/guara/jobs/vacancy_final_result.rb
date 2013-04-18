module Guara
	module Jobs
  		class VacancyFinalResult < ActiveRecord::Base
		    attr_accessible :observation, :result, :salary, 
		    :vacancy_professionals_psychological_evaluation_id, 
		    :vacancy_scheduling_professional_id, :work_start_date

		    belongs_to :psychological, :class_name=> "Guara::Jobs::VacancyProfessionalsPsychologicalEvaluation", :foreign_key=> :vacancy_professionals_psychological_evaluation_id
		    belongs_to :scheduling, :class_name=> "Guara::Jobs::VacancySchedulingProfessional", :foreign_key=> :vacancy_scheduling_professional_id
		    
		end
	end
end
