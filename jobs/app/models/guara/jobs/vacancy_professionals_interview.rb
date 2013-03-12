module Guara
  module Jobs
    class VacancyProfessionalsInterview < ActiveRecord::Base
      attr_accessible :date, :vacancy_scheduling_professsional, :process_instance, :step
      
      belongs_to :vacancy_scheduling_professsional
      belings_to :process_instance
      belongs_to :step
      
      
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
