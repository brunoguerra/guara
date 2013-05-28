
if defined?(ActiveAdmin)
  module Guara
  	module Jobs
	    ActiveAdmin.register LevelEducation, :namespace => :maintence do
	      
	    config.sort_order = "id_asc"

	    end
	end
  end
end