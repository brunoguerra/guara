if defined?(ActiveAdmin)
  module Guara
    ActiveAdmin.register BusinessSegment, :namespace => :maintence do
  
      filter :enabled, :as => :check_boxes
  
      index do
        column :name
        column :enabled
  
    
        default_actions
      end
  
    end
  end
end