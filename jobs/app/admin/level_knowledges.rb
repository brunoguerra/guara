
if defined?(ActiveAdmin)
  module Guara
  	module Jobs
	    ActiveAdmin.register LevelKnowledge, :namespace => :maintence do
	 
	    config.sort_order = "id_asc"
	    end
	end
  end
end