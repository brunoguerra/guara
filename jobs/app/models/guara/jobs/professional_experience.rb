require File.expand_path("../../jobs", __FILE__) if Rails.env.development?

class Guara::Jobs::ProfessionalExperience < ActiveRecord::Base
	    	attr_accessible :activities, :company_name, :date_admission,
	    					:date_resignation, :role, :salary
			
		end
