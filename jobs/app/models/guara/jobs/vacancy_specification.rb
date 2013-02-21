require File.expand_path("../../jobs", __FILE__) if Rails.env.development?

class Guara::Jobs::VacancySpecification < ActiveRecord::Base
	    attr_accessible :business_action, :role, :salary_requirements
	    
	    belongs_to :professional
	    has_and_belongs_to_many :roles, :join_table => "guara_jobs_vacancy_specifications_roles"


	    #accepts_nested_attributes_for :roles
	    has_many :vacancy_specifications_roles, class_name: "Guara::Jobs::VacancySpecificationsRoles", :dependent => :destroy
	    has_many :roles, :through => :vacancy_specifications_roles 
	end

