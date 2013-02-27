module Guara
  module Jobs
    class Vacancy < ActiveRecord::Base
      belongs_to :process_instance
      
      
      def unscheduled_professionals()
        self.process_instance.step
      end
      
      def scheduled_professionals()
        
      end
      
      def selection_professionals_attr()
        @step_profs = ProcessInstance.first.custom_process.steps.joins(:step_attrs).where("guara_jobs_step_attrs.widget='selecionar_candidatos'").first
        @step_attr = @setp_profs.attrs.where("guara_jobs_step_attrs.widget='selecionar_candidatos'").first
        
        @attr_inst = StepInstanceAttr.where(process_instance: self.process_instance, step_attr: @step_attr).first
        @attr_inst.values
      end
        
    end
  end
end
