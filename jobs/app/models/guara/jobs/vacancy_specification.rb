class Guara::Jobs::VacancySpecification < ActiveRecord::Base
	    attr_accessible :business_action, :role, :salary_requirements
	    
	    belongs_to :professional
	    has_and_belongs_to_many :roles, :join_table => "guara_jobs_vacancy_specifications_roles"
	end

