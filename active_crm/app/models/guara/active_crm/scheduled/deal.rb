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
			    								:closed

			    belongs_to :customer, class_name: "Guara::Person"
			    belongs_to :group, class_name: "Guara::ActiveCrm::Scheduled::CustomerGroup", foreign_key: :group_id
			    has_many :contacts, foreign_key: :deal_id 
			    
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
			end
		end
	end
end
