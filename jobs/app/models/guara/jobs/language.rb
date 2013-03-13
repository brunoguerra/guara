module Guara
	module Jobs
	  class Language < ActiveRecord::Base
	    attr_accessible :name, :professional_language_id
	    
	  end
	end
end
