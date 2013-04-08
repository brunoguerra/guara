module Guara
	module Jobs
	  	class VacancySendedProfessionalsMailer < ActionMailer::Base
	    	default from: "macielcr7@gmail.com"

	    	def professionals_email(params)
			    #attachments['terms.pdf'] = File.read('/path/terms.pdf')
			    mail(:to => params[:email],
			         :subject => "Please see the Terms and Conditions attached")
			end
	  	end
	end
end
