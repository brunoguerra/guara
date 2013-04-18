require File.expand_path("../../jobs", __FILE__) if Rails.env.development?


class Guara::Jobs::CustomerInterviewReturn < ActiveRecord::Base
	
	def self.levels
		{
			0 => :aproved,
			1 => :reproved
		}
	end

	def self.levels_translated
		{
			0 => I18n.t("jobs.customer_interview_return.aproved"),
			1 => I18n.t("jobs.customer_interview_return.reproved")
		}
	end
	  	
end

