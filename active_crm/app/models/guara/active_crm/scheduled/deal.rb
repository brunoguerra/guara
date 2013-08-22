module Guara
	module ActiveCrm
		class Scheduled
			class Deal < ActiveRecord::Base
			    attr_accessible :customer_id,
			    								:customer, 
			    								:date_finish, 
			    								:date_start, 
			    								:group_id,
			    								:group,
			    								:scheduled_id,
			    								:scheduled, 
			    								:closed

			    belongs_to :customer, class_name: "Guara::Person"
			    belongs_to :group, class_name: "Guara::ActiveCrm::Scheduled::Group", foreign_key: :group_id
			    belongs_to :scheduled, class_name: "Guara::ActiveCrm::Scheduled"
			    has_many :contacts, foreign_key: :deal_id, class_name: "Guara::ActiveCrm::Scheduled::Contact"
	    		has_many :scheduled_contacts,
						:conditions => "scheduled_at is not null and result in (#{Contact::NOT_CONTACTED}, #{Contact::SCHEDULED})",
						:class_name => "Contact"


			    validates_presence_of :scheduled, :customer

			    def accepted_total
			    	group.registered.where("#{Guara::ActiveCrm::Scheduled::Deal.table_name}.id = ?", self.id).count()
			    end

			    def scheduled_contacts_total
			    	group.scheduled_contacts.where("#{Guara::ActiveCrm::Scheduled::Deal.table_name}.id = ?", self.id).count()
			    end

=begin
				   	scope :count_registered, lambda {|value|
			   	  	where("(
			   	  		SELECT count(*) FROM #{Contact.table_name} as c WHERE c.deal_id = #{Deal.table_name}.id AND
			   	  		c.enabled = true AND c.result = #{Contact.results()[:registered]}
			   	  		) >= #{value}
			   	  	")
			    }

			    scope :no_interested, lambda {
			    	where("#{Contact.table_name}.result = #{Contact.results[:participation_denied]}")
			    }

			    scope :registered, lambda {
			    	where("#{Contact.table_name}.result = #{Contact.results[:registered]}")
			    }

			    scope :count_contacted, lambda{|value|
			    	where("(
			   	  		SELECT count(*) FROM #{Contact.table_name} as c WHERE c.deal_id = #{Deal.table_name}.id AND
			   	  		c.enabled = true
			   	  		) >= #{value}
			   	  	")
			    }
			    
			    search_methods :count_registered
			    search_methods :count_contacted
=end
			end
		end
	end
end
