module Guara
  	module ActiveCrm
  		class ScheduledCustomerGroup < ActiveRecord::Base
    		attr_accessible :business_activities, :business_segments, :employes_max, :employes_min,
    		:scheduled_id, :name_contains, :finished_id, :pair_or_odd, :doc_equals, :district_contains
  		end
  	end
end

