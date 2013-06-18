
if defined?(ActiveAdmin)
  module Guara
  	module ActiveCrm
  		module Scheduled
		    ActiveAdmin.register Guara::ActiveCrm::Scheduled::Classified, :namespace => :maintence do
		      
		    end
		end
	end
  end
end