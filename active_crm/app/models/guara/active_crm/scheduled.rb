module Guara
	module ActiveCrm
	  class Scheduled < ActiveRecord::Base
	    attr_accessible :date_finish, :date_start, :subject, :user_id, :task_type_id, :status
	  
	    belongs_to :task_type, class_name: "Guara::TaskType"
	    belongs_to :user, class_name: "Guara::User"

	    has_many :customer_group, class_name: "Guara::ActiveCrm::ScheduledCustomerGroup", foreign_key: :scheduled_id

	    def self.status 
	    	{
	    		0 => :open,
	    	  	1 => :completed
	    	}
	    end

	    def self.translate_status
	    	{
	    		0 => I18n.t("active_crm.scheduled.status.open"),
	    	  	1 => I18n.t("active_crm.scheduled.status.completed")
	    	}
	    end


		  default_scope order('created_at DESC')
	  
	  end
	end
end
