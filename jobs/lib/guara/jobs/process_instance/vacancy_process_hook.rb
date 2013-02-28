
module Guara
  module Jobs
    class VacancyProcessHook
      def initialize(obj)
        def obj.hook_after_save()
          vacancy = Vacancy.find_by_process_instance_id(self.id)
          vacancy = Vacancy.new(process_instance: self) if (vacancy.nil?)
          vacancy.save
        end
      end
    end
    
  end
end