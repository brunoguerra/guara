
module Guara
	module Jobs
		class Professional < ActiveRecord::Base
			#==================================> ATTRIBUTES <============================#
			attr_accessible :have_job, :business_action, :salary_requirements, 
							:vacancy_specifications, :vacancy_specification_attributes,
							:formation_attributes, 
							:professional_experiences_attributes


			#==============================> ASSOCIATE <============================#
	    	belongs_to :person
	    	belongs_to :customer, foreign_key: "person_id"

	    
	  		has_many :formations, dependent: :destroy
	  		has_many :professional_experiences, dependent: :destroy
	  		has_one :vacancy_specification, dependent: :destroy



	  		 accepts_nested_attributes_for :formations

	  		 accepts_nested_attributes_for :professional_experiences
	  		 
	  		 accepts_nested_attributes_for :vacancy_specification

		end
	end
end  	

