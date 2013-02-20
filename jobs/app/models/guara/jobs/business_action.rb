require File.expand_path("../../jobs", __FILE__) if Rails.env.development?


class Guara::Jobs::BusinessAction < ActiveRecord::Base
	    attr_accessible :name
	  	
end

