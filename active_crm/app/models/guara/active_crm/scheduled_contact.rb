module Guara
	module ActiveCrm
  		class ScheduledContact < ActiveRecord::Base
    		belongs_to :contact
    		belongs_to :classified
    		belongs_to :scheduled
    	
    		attr_accessible :activity, :result, :scheduled, :scheduled_id
  		end
  	end
end
