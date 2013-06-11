module Guara
  	module ActiveCrm
  		module Scheduled
	  		class CustomerGroup < ActiveRecord::Base
	    		attr_accessible :business_activities, :business_segments, :employes_max, :employes_min,
	    		:scheduled_id, :name_contains, :finished_id, :pair_or_odd, :doc_equals, :district_contains

	    		has_many :deals, class_name: "Guara::ActiveCrm::Scheduled::Deals", foreign_key: :groups
	  		end
	  	end
  	end
end

