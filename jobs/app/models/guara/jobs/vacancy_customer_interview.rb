module Guara
	module Jobs
  		class VacancyCustomerInterview < ActiveRecord::Base
    		attr_accessible :motive, :return_date, :return_interview, 
    		:vacancy_sended_professionals_id, :vacancy_scheduling_professional_id 

    		belongs_to :vacancy_sended_professionals
    		belongs_to :scheduling, :class_name=> "Guara::Jobs::VacancySchedulingProfessional", :foreign_key=> :vacancy_scheduling_professional_id
        has_one :psychological, :class_name=> "Guara::Jobs::VacancyProfessionalsPsychologicalEvaluation"

    		validates :return_interview, :presence => true
    		validates :return_date, :presence => true
    		validates :motive, :presence => true, :if => "self.return_interview == 1"
  		end
  	end	
end
