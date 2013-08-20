module Guara
  	module ActiveCrm
  		class Scheduled
	  		class Group < ActiveRecord::Base
	    		attr_accessible :business_activities,
	    										:business_segments, 
	    										:employes_max, 
	    										:employes_min,
	    										:scheduled,
	    										:scheduled_id, 
	    										:name_contains, 
	    										:finished_id, 
	    										:pair_or_odd, 
	    										:doc_equals, 
	    										:district_contains

	    		SQL_NEW_TO_CONTACT = %Q{
	    				customer_type = 'Guara::CustomerPj' AND 
	 						(Select count(*) from #{Guara::ActiveCrm::Scheduled::Deal.table_name} as d 
        				where d.customer_id = #{Guara::Customer.table_name}.id and d.scheduled_id = ?) = 0
					}

	    		has_many :contacts
	    		has_many :deals, foreign_key: :group_id
	    		belongs_to :scheduled
	    		has_many :scheduled_contacts,
	    						 :conditions => "scheduled_at is not null and result = #{Contact::SCHEDULED}",
	    						 class_name: "Contact"

	    		def registered
	    			Group.joins(:contacts, :deals)
	    			.where(
							"#{Deal.table_name}.group_id = ? and 
							 #{Contact.table_name}.result = ? ", 
							 self.id, 
							 Contact::ACCEPTED
	    			)
	    		end

	    		include Guara::ActiveCrm::ScheduledsHelper

	    		def name
	    			@name = "Grupo de Cliente #{self.id}"
	    		end

	    		def name=(value)
	    			@name = value
	    		end

	    		def to_contact
	    			Guara::Customer.where(SQL_NEW_TO_CONTACT, self.scheduled.id).
	    				search(prepare_filter_search({}, self))
	    		end

	    		def count_registered
		        return registered.count
	    		end

	    		def count_customers
    				return Guara::Customer.where(:customer_type=> 'Guara::CustomerPj').search(prepare_filter_search({}, self)).count()
	    		end

	    		def count_scheduled
	    			return scheduled_contacts.count
	    		end

	    		def count_schedule
    				return to_contact.count
	    		end
	  		end
	  	end
  	end
end

