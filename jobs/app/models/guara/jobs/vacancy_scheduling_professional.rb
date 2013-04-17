module Guara
  module Jobs
    class VacancySchedulingProfessional < ActiveRecord::Base
      attr_accessible :date_time, :local, :avaliate, :description, 
      :date_time_interviewee, :consultant_id, :vacancy_id, 
      :professional_id, :interested

      belongs_to :process_instance
      belongs_to :consultant
      belongs_to :vacancy
      belongs_to :professional
      has_one :interview, class_name: "Guara::Jobs::VacancyProfessionalsInterview", foreign_key: "scheduling_id"

      def self.unscheduled_professionals(vacancy)
        selection_professionals_selecteds = vacancy.selection_professionals_selecteds().reject do |p|
          vacancy_scheduling_professional = VacancySchedulingProfessional.where(vacancy_id: vacancy.id, professional_id: p.id).first()
          p[:interested] = vacancy_scheduling_professional.nil? ? nil : vacancy_scheduling_professional.interested
          vacancy_scheduling_professional.nil?
        end

        return selection_professionals_selecteds
      end
      
      def self.scheduled_professionals(vacancy)
        return vacancy.selection_professionals_selecteds().reject do |p|
          VacancySchedulingProfessional.where(vacancy_id: vacancy.id, professional_id: p.id).count()>0
        end
      end
     
    end
  end
end
