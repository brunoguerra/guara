# encoding: UTF-8

module Guara
	module Jobs
	  	class SendedCustomerValidationsMailer < ActionMailer::Base
	    	default from: "ti@woese.com"

	    	def validation_email(params)
				@customer = params[:customer]
				@data = params[:data]
				mail(:to => @customer.emails.first.email, :subject => "CMGB* Serviço de RH - Relatório de Validação")
			end
			
	  	end
	end
end
