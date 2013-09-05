module Guara
  	module ActiveCrm
  		class Scheduled
	  		class Group < ActiveRecord::Base
	    		include Guara::ActiveCrm::ScheduledsHelper

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
	 						#{Guara::Customer.table_name}.id NOT IN (Select customer_id from #{Guara::ActiveCrm::Scheduled::Deal.table_name} as d 
        				where d.customer_id = #{Guara::Customer.table_name}.id and d.scheduled_id = ?) AND
							#{Guara::Customer.table_name}.id NOT IN (Select customer_id from #{Guara::ActiveCrm::Scheduled::Ignored.table_name} as i 
        				where i.customer_id = #{Guara::Customer.table_name}.id and i.group_id = ?)
					}

	    		has_many :deals, foreign_key: :group_id
	    		has_many :ignored, class_name: "Scheduled::Ignored"
	    		has_many :contacts, through: :deals
	    		belongs_to :scheduled
	    		has_many :scheduled_contacts,
	    						 :through => :deals,
	    						 :class_name => "Contact"

	    		has_many :expired_contacts,
	    						 :through => :deals,
	    						 :source => :scheduled_contacts,
	    						 :class_name => "Contact",
	    						 :conditions => ["scheduled_at < ?", Time.zone.now]


	    		def registered
	    			Group.joins(:contacts, :deals)
	    			.where(
							"#{Deal.table_name}.group_id = ? and 
							 #{Contact.table_name}.result = ? ", 
							 self.id, 
							 Contact::ACCEPTED
	    			)
	    		end

	    		def name
	    			@name = "Grupo de Cliente #{self.id}"
	    		end

	    		def name=(value)
	    			@name = value
	    		end

	    		def to_contact(offset=0)
	    			Guara::Customer.select('LOWER(guara_people.name), guara_people.id, guara_people.*').where(SQL_NEW_TO_CONTACT, self.scheduled.id, self.id).offset(offset).uniq.search(prepare_filter_search({}, self))
	    		end

	    		#TODO: rf accepteds_total
	    		def count_registered
		        return registered.count
	    		end

	    		#TODO: rf customers_total
	    		def count_customers
    				return Guara::Customer.where(:customer_type=> 'Guara::CustomerPj').search(prepare_filter_search({}, self)).count()
	    		end

	    		#TODO: rf scheduleds_total
	    		def count_scheduled
	    			return contacts.count
	    		end

	    		#TODO: rf to_contact_total
	    		def count_schedule
    				return to_contact.count
	    		end

	    		def find_or_create_deal(customer)
	    			deal = Scheduled::Deal.where(group_id: self.id, customer_id: customer.id).first
	    			if deal.nil?
		    			deal = self.scheduled.initialize_deal(customer, self)
		    			deal.save!
		    		end
	    			deal
	    		end
	  		end
	  	end
  	end
end

