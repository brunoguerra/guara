if defined?(ActiveAdmin)
  module Guara
  	module Jobs
	    ActiveAdmin.register Role, :namespace => :maintence do


	    	form do |f|
	    		f.inputs "Conteiner" do
		    		f.input :business_action, :collection =>  Guara::Jobs::BusinessAction.all 
		    		f.input :name
	    		end
	    		f.buttons
	    	end

	    	config.sort_order = "name_asc"
	      
	    end
	end
  end
end