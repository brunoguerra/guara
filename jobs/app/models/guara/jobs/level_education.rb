class Guara::Jobs::LevelEducation < ActiveRecord::Base
    	attr_accessible :name
  		
  		has_many :formation
  		
  	end

