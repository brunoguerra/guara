require File.expand_path("../../jobs", __FILE__) if Rails.env.development?


class Guara::Jobs::VacancySpecificationsRoles < ActiveRecord::Base
	belongs_to :role
	belongs_to :vacancy_specification
	# attr_accessible :title, :body
end
