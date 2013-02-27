require File.expand_path("../../jobs", __FILE__) if Rails.env.development?

class Guara::Jobs::Formation < ActiveRecord::Base
    attr_accessible :course, :description, :level_education_id, :situation,
    				:name_institution, :formation_id, :date_conclusion 
	
	belongs_to :level_education

end
 