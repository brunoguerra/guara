module Guara
	module ActiveCrm
	  class Scheduled < ActiveRecord::Base
	    attr_accessible :date_finish, :date_start, :subject, :user_id, :task_type_id
	  
	    belongs_to :task_type, class_name: "Guara::TaskType"
	    belongs_to :user, class_name: "Guara::User"
	  
	  end
	end
end
