module Guara
	module ActiveCrm
		module Scheduled
  			class Deals < ActiveRecord::Base
			    attr_accessible :customer_pj_id, :date_finish, :date_start, :scheduled_id, :groups_id, :closed

			    belongs_to :customer_pj, class_name: "Guara::CustomerPj", foreign_key: :customer_pj_id
			    belongs_to :group, class_name: "Guara::ActiveCrm::Scheduled::CustomerGroup", foreign_key: :groups_id
			   
			end
		end
	end
end
