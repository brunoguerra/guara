
if defined?(ActiveAdmin)
  module Guara
  	module ActiveCrm
  		module Scheduled
		    ActiveAdmin.register Guara::ActiveCrm::Scheduled::Classified, :namespace => :maintence do
		     
		     config.sort_order = "name_asc"
		     
		    end
		end
	end
  end
end