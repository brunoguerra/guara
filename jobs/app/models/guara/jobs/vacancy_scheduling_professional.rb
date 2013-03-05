module Guara
  module Jobs
    class VacancySchedulingProfessional < ActiveRecord::Base
      attr_accessible :date_time, :local, :avaliate, :description, :date_time_interviewee, :consultant_id, :vacancy_id, :professional_id

      belongs_to :process_instance
      belongs_to :consultant
      belongs_to :vacancy
      belongs_to :professional
      has_many :professionals
     
      def self.unscheduled_professionals(vacancy)
        return vacancy.selection_professionals_selecteds().reject do |p|
          VacancySchedulingProfessional.where(vacancy_id: vacancy.id, professional_id: p.id).count()==0
        end
      end
      
      def self.scheduled_professionals(vacancy)
        return vacancy.selection_professionals_selecteds().reject do |p|
          VacancySchedulingProfessional.where(vacancy_id: vacancy.id, professional_id: p.id).count()>0
        end
      end
     
    end
  end
end
