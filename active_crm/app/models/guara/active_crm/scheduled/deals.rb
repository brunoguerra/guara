module Guara
	module ActiveCrm
		module Scheduled
  			class Deals < ActiveRecord::Base
			    attr_accessible :customer_pj_id, :date_finish, :date_start, :scheduled_id, :groups_id, :closed

			    belongs_to :customer_pj, class_name: "Guara::Customer", foreign_key: :customer_pj_id
			    belongs_to :group, class_name: "Guara::ActiveCrm::Scheduled::CustomerGroup", foreign_key: :groups_id
			    has_many :contacts, foreign_key: :deal_id 
			   	

			   	scope :count_registered, lambda {|value|
			   	  	where("(
			   	  		SELECT count(*) FROM #{Contact.table_name} as c WHERE c.deal_id = #{Deals.table_name}.id AND
			   	  		c.enabled = true AND c.result = #{Contact.results()[:registered]}
			   	  		) >= #{value}
			   	  	")
			    }

			    scope :count_contacted, lambda{|value|
			    	where("(
			   	  		SELECT count(*) FROM #{Contact.table_name} as c WHERE c.deal_id = #{Deals.table_name}.id AND
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
