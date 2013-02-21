require File.expand_path("../../jobs", __FILE__) if Rails.env.development?


class Guara::Jobs::Role < ActiveRecord::Base
	attr_accessible :name, :business_action_id

	belongs_to :business_action

	has_and_belongs_to_many :vacancy_specifications, :class_name => "Guara::Jobs::VacancySpecificationsRoles"
	#alias_method :guara_jobs_vacancy_specifications, :vacancy_specification
end

