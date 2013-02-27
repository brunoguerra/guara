
module Guara
	module Jobs
		class Professional < ActiveRecord::Base
			include Guara::Core::Engine.routes.url_helpers

			#==================================> ATTRIBUTES <============================#
			attr_accessible :have_job, :business_action, :salary_requirements, 
							:vacancy_specifications, :vacancy_specification_attributes,
							:formations_attributes, :languages,
							:professional_experiences_attributes

			delegate :name, to: :person


			#==============================> ASSOCIATE <============================#
	    	belongs_to :person
	    	belongs_to :customer, foreign_key: "person_id"

	    
	  		has_many :formations, dependent: :destroy
	  		has_many :professional_experiences, dependent: :destroy
	  		has_one :vacancy_specification, dependent: :destroy
	  		has_many :languages



	  		accepts_nested_attributes_for :formations

	  		accepts_nested_attributes_for :professional_experiences
	  		 
	  		accepts_nested_attributes_for :vacancy_specification


	  		def base_uri
			    self.new_record? ? new_customer_professional_path(self.customer, self) : customer_professional_path(self.customer, self)
			end

		end
	end
end  	

require File.expand_path("../../../../../config/crm_config.rb", __FILE__) if Rails.env.development?
