module Guara
  module Jobs
    class VacancyProcessHook
      include Guara::ActiveProcess::ProcessHooker
      
      FIELDS_STEP_OPENING = [:system_name,
                              :customer_id,
                              :role_id,
                              :type_id,
                              :total,
                              :salary_id,
                              :consultante_id]
      
      
      def initialize(obj)
        def obj.hook_after_save()
          vacancy = Vacancy.find_by_process_instance_id(self.id)
          vacancy = Vacancy.new(process_instance: self) if (vacancy.nil?)
          vacancy.save
        end
      end
      
      
      def self.widget_show
        "guara/jobs/vacancy/widget_vacancy_status"
      end
      
      def self.step_instace_after_save(step_instance_attrs, process_instance, step)
        vacancy = Guara::Jobs.Vacancy.where(process_instance: process_instance).first
        if step.level==1          
          step_instance_attrs.each do |sattr|
            sys_name = sattr.step_attr.system_name.to_s
            if (FIELDS_STEP_OPENING.include?(sys_name.to_sym)
              vacancy.send(sys_name+"=").to_sym, attr.value)
            end
          end
          vacancy.save!
        end
        
      end
      
    end
    
  end
end