module Guara
	module Jobs
  		class VacancySendedProfessionals < ActiveRecord::Base
    		belongs_to :vacancy_scheduling_professional
    		has_one :customer_interview, :class_name=> "Guara::Jobs::VacancyCustomerInterview", :foreign_key=> "vacancy_sended_professionals_id"

    		attr_accessible :date, :step_instance_id, :vacancy_scheduling_professional_id

    		def self.unsended_professionals(vacancy_scheduling_professionals)
	        	return vacancy_scheduling_professionals.reject do |p|
	          		VacancySendedProfessionals.where(vacancy_scheduling_professional_id: p.id).count()==0
	        	end
	      	end

	      	def self.sended_professionals(vacancy_scheduling_professionals)
	        	return vacancy_scheduling_professionals.reject do |p|
	          		VacancySendedProfessionals.where(vacancy_scheduling_professional_id: p.id).count()>0
	        	end
	      	end

  		end
  	end	
end
