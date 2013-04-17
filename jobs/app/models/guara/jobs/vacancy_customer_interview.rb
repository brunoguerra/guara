module Guara
	module Jobs
  		class VacancyCustomerInterview < ActiveRecord::Base
    		attr_accessible :motive, :return_date, :return_interview, :vacancy_sended_professionals_id

    		belongs_to :vacancy_sended_professionals

    		validates :return_interview, :presence => true
    		validates :return_date, :presence => true
    		validates :motive, :presence => true, :if => "self.return_interview == 1"
  		end
  	end	
end
