module Guara
  module TasksHelper

    def task_alert_level_class(task)
    
      return "success" if (task.done?)
    
      case task.due_critical_level
        when 3
          "important"        
        when 2
          "info"
        else
          ""
      end
    
    
    end

  end
end