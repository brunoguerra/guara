module Guara
	module ActiveCrm
	  class Scheduled < ActiveRecord::Base
	    belongs_to :task_type
	    belongs_to :user
	    attr_accessible :date_finish, :date_start, :subject
	  end
	end
end
