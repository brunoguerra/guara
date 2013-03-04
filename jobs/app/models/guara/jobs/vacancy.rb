module Guara
  module Jobs
    class Vacancy < ActiveRecord::Base
      attr_accessible :process_instance
      belongs_to :process_instance
      
      
      def unscheduled_professionals()
      end
      
      def scheduled_professionals()
        
      end
      
      def selection_professionals_values()
        @step_profs = ProcessInstance.first.custom_process.steps.joins(:step_attrs).where("guara_jobs_step_attrs.widget='selecionar_candidatos'").first
        raise "Unkow step with professionals selection" if @step_profs.nil?
        @step_attr = @step_profs.attrs.where("guara_jobs_step_attrs.widget='selecionar_candidatos'").first
        
        @attr_inst = StepInstanceAttr.where(process_instance_id: self.process_instance.id, step_attr_id: @step_attr.id).first
        raise "Unkow attrs with professionals selection" if @attr_inst.nil?
        @attr_inst.values.map { |v| Professional.find v.value }

      end
      
      def self.custom_process
        CustomProcess.where(name: 'vacancy').order(:created_at).last
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
