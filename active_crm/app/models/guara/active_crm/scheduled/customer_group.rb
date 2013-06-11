module Guara
  	module ActiveCrm
  		module Scheduled
	  		class CustomerGroup < ActiveRecord::Base
	    		attr_accessible :business_activities, :business_segments, :employes_max, :employes_min,
	    		:scheduled_id, :name_contains, :finished_id, :pair_or_odd, :doc_equals, :district_contains

	    		has_many :deals, class_name: "Guara::ActiveCrm::Scheduled::Deals", foreign_key: :groups_id

	    		def count_registered
	    			table_contact = Guara::ActiveCrm::Scheduled::Contact
		            table_deals   = Guara::ActiveCrm::Scheduled::Deals
		            return table_contact.joins(:deal)
		              .where("#{table_deals.table_name}.groups_id = #{self.id} AND 
		              #{table_contact.table_name}.result = #{table_contact.results()[:registered]}")
		              .count()
	    		end

	    		def count_scheduled
	    			table_contact = Guara::ActiveCrm::Scheduled::Contact
		            table_deals   = Guara::ActiveCrm::Scheduled::Deals
		            return table_contact.joins(:deal)
		              .where("#{table_deals.table_name}.groups_id = #{self.id} AND 
		              #{table_contact.table_name}.result = #{table_contact.results()[:scheduling]}")
		              .count()
	    		end
	  		end
	  	end
  	end
end

