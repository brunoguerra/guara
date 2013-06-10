module Guara
	module ActiveCrm
  		class ScheduledContact < ActiveRecord::Base
    		belongs_to :contact
    		belongs_to :classified
    		belongs_to :schedule, class_name: "Guara::ActiveCrm::Scheduled", foreign_key: :scheduled_id
    	
    		attr_accessible :activity, :result, :scheduled, :scheduled_id, :contact_id, 
    		:classified_id

        def status
          
        end

  		end
  	end
end
