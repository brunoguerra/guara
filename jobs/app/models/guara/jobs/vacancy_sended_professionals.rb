module Guara
	module Jobs
  		class VacancySendedProfessionals < ActiveRecord::Base
    		belongs_to :vacancy_scheduling_professional
    		attr_accessible :date, :step_instance_id, :vacancy_scheduling_professional_id

    		def self.unsended_professionals(vacancy_scheduling_professional)
	        	return vacancy_scheduling_professional.selection_professionals_selecteds().reject do |p|
	          		VacancySendedProfessionals.where(vacancy_scheduling_professional_id: p.id).count()==0
	        	end
	      	end

	      	def self.sended_professionals(vacancy_scheduling_professional)
	      		@vacancy_id = self.vacancy_scheduling_professional.vacancy_id
	        	return vacancy_scheduling_professional.selection_professionals_selecteds(@vacancy_id).reject do |p|
	          		VacancySendedProfessionals.where(vacancy_scheduling_professional_id: p.id).count()>0
	        	end
	      	end

  		end
  	end	
end
