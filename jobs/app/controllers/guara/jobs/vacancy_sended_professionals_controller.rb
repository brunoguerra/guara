module Guara
  module Jobs
    class VacancySendedProfessionalsController < BaseController
    	
    	def load_selecteds_professionals()
			@unscheduleds = VacancySendedProfessionals.unsended_professionals(@vacancy)
	        @scheduleds   = VacancySendedProfessionals.sended_professionals(@vacancy)
	    end

    	def index
    		
    	end
    end
  end
end    
