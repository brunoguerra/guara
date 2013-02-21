module Guara
  module TasksHelper

    def task_alert_level_class(task)
    
      return "alert-success" if (task.done?)
    
      case task.due_critical_level
        when 3
          "alert-error"        
        when 2
          "alert-info"
        else
          ""
      end
    
    
    end

  end
end