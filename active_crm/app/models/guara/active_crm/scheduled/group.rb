module Guara
  	module ActiveCrm
  		class Scheduled
	  		class Group < ActiveRecord::Base
	    		attr_accessible :business_activities, :business_segments, :employes_max, :employes_min,
	    		:scheduled_id, :name_contains, :finished_id, :pair_or_odd, :doc_equals, :district_contains

	    		SQL_NEW_TO_CONTACT = %Q{
	    				customer_type = 'Guara::CustomerPj' AND 
	 						(Select count(*) from #{Guara::ActiveCrm::Scheduled::Deal.table_name} as d 
        				where d.customer_id = #{Guara::Customer.table_name}.id and d.group_id = ?) = 0
					}

	    		attr_accessor :name

	    		has_many :contacts
	    		has_many :deals, foreign_key: :group_id
	    		belongs_to :scheduled
	    		has_many :scheduled_contacts, class_name: "Guara::ActiveCrm::Scheduled::Contact", -> { where "scheduled_at not null and result = #{Contact::SCHEDULED}  " }

	    		scope :registered, :lambda { joins(:contacts, :deals).where("#{Deals.table_name}.group_id": self.id, "#{Contact.table_name}.result": Contact::ACCEPTED) }

	    		include Guara::ActiveCrm::ScheduledsHelper

	    		def name
	    			@name = "Grupo de Cliente #{self.id}"
	    		end

	    		def name=(value)
	    			@name = value
	    		end

	    		def to_contact
	    			Guara::Customer.where(SQL_NEW_TO_CONTACT % group_id).
	    				search(prepare_filter_search({}, self))
	    		end

	    		def count_registered
		        return registered.count
	    		end

	    		def count_customers
	    			search = prepare_filter_search({}, self)    			
    				return Guara::Customer.where(:customer_type=> 'Guara::CustomerPj').search(search).count()
	    		end

	    		def count_scheduled
	    			table_contact = Guara::ActiveCrm::Scheduled::Contact
		            table_deals   = Guara::ActiveCrm::Scheduled::Deal
		            return table_contact.joins(:deal)
		              .where("#{table_deals.table_name}.group_id = #{self.id} AND 
		              #{table_contact.table_name}.result = #{table_contact.results()[:scheduling]} AND enabled = true")
		              .count()
	    		end

	    		def count_schedule
	    			search = prepare_filter_search({}, self)
	    			table_deals = Guara::ActiveCrm::Scheduled::Deal
	    			table_customer = Guara::Customer
    				return Guara::Customer.where("#{table_customer.table_name}.customer_type = 'Guara::CustomerPj' AND 
    					#{table_customer.table_name}.id NOT IN(select a1.customer_id from #{table_deals.table_name} as a1 where a1.group_id = #{self.id})")
    				.search(search).count()
	    		end
	  		end
	  	end
  	end
end

