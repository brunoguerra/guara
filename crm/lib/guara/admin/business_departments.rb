
if defined?(ActiveAdmin)
  module Guara
    ActiveAdmin.register BusinessDepartment, :namespace => :maintence do
  		
    	config.sort_order = "name_asc"
  		
    end
  end
end
