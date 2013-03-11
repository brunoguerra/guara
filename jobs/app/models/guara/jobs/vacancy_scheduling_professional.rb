module Guara
  module Jobs
    class VacancySchedulingProfessional < ActiveRecord::Base
      attr_accessible :date_time, :local, :avaliate, :description, 
      :date_time_interviewee, :consultant_id, :vacancy_id, 
      :professional_id, :type_interview, :retrospect_professional, :prospective_plans

      belongs_to :process_instance
      belongs_to :consultant
      belongs_to :vacancy
      belongs_to :professional
      has_many :professionals

      has_and_belongs_to_many :perception_questions, :join_table => "guara_jobs_auto_perceptions_professionals"

      has_many :auto_perceptions_professionals, class_name: "Guara::Jobs::AutoPerceptionsProfessionals", :dependent => :destroy
      has_many :perception_questions, :through => :auto_perceptions_professionals 

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
