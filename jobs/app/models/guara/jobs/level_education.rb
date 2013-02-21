require File.expand_path("../../jobs", __FILE__) if Rails.env.development?

class Guara::Jobs::LevelEducation < ActiveRecord::Base
    	attr_accessible :name
  		
  		has_many :formation
  		
  	end

