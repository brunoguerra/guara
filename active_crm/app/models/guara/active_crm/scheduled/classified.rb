module Guara
	module ActiveCrm
		module Scheduled
			def self.table_name_prefix
		      'guara_active_crm_scheduled_'
		    end
		    
	  		class Classified < ActiveRecord::Base
	    		attr_accessible :name, :enable
	  		end
	  	end
  	end
end

