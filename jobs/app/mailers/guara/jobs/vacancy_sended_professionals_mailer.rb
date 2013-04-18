# encoding: UTF-8

module Guara
	module Jobs
	  	class VacancySendedProfessionalsMailer < ActionMailer::Base
	    	default from: "ti@woese.com"

	    	def professionals_email(params)
				@customer_pj = params[:customer_pj]
				params[:vacancy_scheduling_professionals].each do |vacancy_scheduling_professional|
					load_pdf_professional(vacancy_scheduling_professional)
				end
			    mail(:to => @customer_pj.emails.first().email, :subject => "Relatório de Profissionais Selecionados")
			end

			private

			def load_pdf_professional(vacancy_scheduling_professional)
				@professional = vacancy_scheduling_professional.professional

		        @path_pdf  = Rails.root.join('../guara/jobs/lib/guara/jobs/vacancy_sended_professionals_pdf')
	        	@file_name = "#{vacancy_scheduling_professional.vacancy_id}_#{@professional.id}.pdf"
	          	@file_path  = "#{@path_pdf}/#{@file_name}"

	          	if !File.exist?(@file_path)
	          		generate_pdf_to_professional()
	          		@interviewer_professional = vacancy_scheduling_professional.interview
	          	end

	          	return attachments[@file_name] = File.read(@file_path)
		    end

		    def generate_pdf_to_professional()
		    	pdf = WickedPdf.new.pdf_from_string(
	            	render_to_string(:pdf => @file_name, :template => "guara/jobs/vacancy_sended_professionals/show_professional")
	          	)

	          	File.open(@file_path, 'wb') do |file|
				  file << pdf
				end
		    end
	  	end
	end
end
