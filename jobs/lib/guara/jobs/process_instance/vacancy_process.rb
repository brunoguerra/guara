
module Guara
  module Jobs
    class VacancyProcess
      def initialize(obj)
        def obj.hook_after_save()
          vacancy = Vacancy.find_by_process_instance_id(obj.id)
          vacancy.new(process_instance: obj) if (vacancy.nil?)
          vacancy.save
        end
      end
    end
    
  end
end