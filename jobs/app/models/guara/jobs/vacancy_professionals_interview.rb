module Guara
  module Jobs
    class VacancyProfessionalsInterview < ActiveRecord::Base
      attr_accessible :date, :vacancy_scheduling_professsional, :step,
                      :interview_process_instance, :interview_process_instance_id, :scheduling_id, :vacancy_step_id
      
      belongs_to :scheduling, class_name: "Guara::Jobs::VacancySchedulingProfessional"
      belongs_to :interview_process_instance, class_name: "Guara::Jobs::ProcessInstance"
      belongs_to :vacancy_step, class_name: "Guara::Jobs::Step"
      
      
      def self.custom_process
        CustomProcess.where(name: 'professionals_interview').order(:created_at).last
      end
      
      
      def self.custom_process_id
        cp = self.custom_process
        unless cp.nil?
          cp.id
        else
          -1
        end
        
      end
      
    end
  end
end
