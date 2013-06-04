
if defined?(ActiveAdmin)
  module Guara
  	module Jobs
	    ActiveAdmin.register Language, :namespace => :maintence do
	 	
	 	config.sort_order = "name_asc"
	    end
	end
  end
end