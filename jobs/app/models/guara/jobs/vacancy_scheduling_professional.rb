module Guara
  module Jobs
    class VacancySchedulingProfessional < ActiveRecord::Base
      attr_accessible :date_time, :local, :consultant_id, :vacancy_id, :professional_id




      belongs_to :process_instance
      belongs_to :consultant
      belongs_to :vacancy
      has_many :professionals
      
     
    end
  end
end
