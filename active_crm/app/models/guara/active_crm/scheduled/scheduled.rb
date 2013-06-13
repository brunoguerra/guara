module Guara
	module ActiveCrm
		module Scheduled
		  class Scheduled < ActiveRecord::Base
		    attr_accessible :date_finish, :date_start, :subject, :user_id, :task_type_id, :status

		    attr_accessor :name
		  
		    belongs_to :task_type, class_name: "Guara::TaskType"
		    belongs_to :user, class_name: "Guara::User"

		    has_many :customer_group

			default_scope order('created_at DESC')

			def name
				"#{self.date_start.strftime("%d/%m/%Y")} - #{self.user.name} - #{self.task_type.name}"
			end

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
		  end
		end
	end
end
