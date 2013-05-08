module Guara
  class Jobs::VacancyStatusHistory < ActiveRecord::Base
    belongs_to :user
    belongs_to :vacancy
    attr_accessible :status_new, :status_old, :user, :vacancy

    def status_to
    	Guara::Jobs::VacancyStatus.enum[self.status_new]
    end

    def status_from
			Guara::Jobs::VacancyStatus.enum[self.status_old]
    end
  end
end
