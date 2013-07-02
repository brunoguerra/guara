module Guara
  module Jobs
    class VacancyProcessHook
      include Guara::ActiveProcess::ProcessHooker
      
      FIELDS_STEP_OPENING = [ :customer_pj_id,
                              :role_id,
                              :type_id,
                              :total,
                              :salary_id,
                              :consultant_id]
      
      def initialize(obj)
        def obj.hook_after_save()
          vacancy = Vacancy.find_by_process_instance_id(self.id)
          vacancy = Vacancy.new(process_instance: self) if (vacancy.nil?)
          vacancy.save
        end
      end
       
      def self.widget_show
        "guara/jobs/vacancies/widget_vacancy_status"
      end
      
      def self.step_instance_after_save(step_instance_attrs, process_instance, step)
        vacancy = Guara::Jobs::Vacancy.where(process_instance_id: process_instance).first
        if step.level==0
          step_instance_attrs.each do |sattr|
            sys_name = sattr.step_attr.system_name.to_s
            if FIELDS_STEP_OPENING.include?(sys_name.to_sym)
              if sattr.step_attr.type_field == "select"
                vacancy.send((sys_name+"_multi=").to_sym, sattr.values.map(&:value))
              else
                vacancy.send((sys_name+"=").to_sym, sattr.value)
              end
            end
          end
          vacancy.save!
        end
        
      end

      def self.finish_process_actions()
        actions = []
        VacancyStatus::CLOSE_ACTIONS.each do |close_action|
            actions << {
              title: I18n.t("jobs.vacancy_status.%s" % close_action.name),
              path: Guara::Core::Engine.routes.url_helpers.vacancy_change_status_path(self, status_id: close_action.id)
              }
        end

        actions
      end
      
    end
    
  end
end