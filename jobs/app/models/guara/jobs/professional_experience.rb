require File.expand_path("../../jobs", __FILE__) if Rails.env.development?

class Guara::Jobs::ProfessionalExperience < ActiveRecord::Base
	    	attr_accessible :company_name, :careers, :careers_attributes, 
	    						:professional_experiences_id

	    	validates :company_name, :presence => true

	    	has_many :careers, dependent: :destroy 

	    	accepts_nested_attributes_for :careers
			
		end
