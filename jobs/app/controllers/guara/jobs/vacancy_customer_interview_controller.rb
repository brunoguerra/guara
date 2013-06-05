module Guara
	module Jobs
    	class VacancyCustomerInterviewController < BaseController
    		load_and_authorize_resource :vacancy, :class => "Guara::Jobs::Vacancy"
	      	load_and_authorize_resource :scheduling, through: :vacancy, :class => "Guara::Jobs::VacancySchedulingProfessional", :except => [:new]
	      	load_and_authorize_resource :sended, :class => "Guara::Jobs::VacancySendedProfessionals"

    		include ::Guara::Jobs::ActiveProcess::ProcessStepComponent

    		def load_selecteds_professionals()
    			@vacancy = @vacancy || Vacancy.find_by_process_instance_id(params[:process_instance_id])
		        @sended_professionals = VacancySchedulingProfessional
		        	.select('guara_jobs_vacancy_sended_professionals.*, guara_jobs_vacancy_scheduling_professionals.*, guara_jobs_vacancy_sended_professionals.id as sended_id')
		        	.joins(:sended).where(:vacancy_id=> @vacancy.id, :interested=> true).order("avaliate DESC")
		    end

    		def index
    			load_selecteds_professionals()
    			render :partial => "guara/jobs/vacancy_customer_interview/widget_index", :locals => { vacancy: @vacancy}
    		end

    		def show
    			load_selecteds_professionals()
    			render :partial => "guara/jobs/vacancy_customer_interview/widget_show", :locals => { vacancy: @vacancy}
    		end

    		def new
    			@vacancy = Vacancy.find(params[:vacancy_id])
    			@vacancy_customer_interview = VacancyCustomerInterview.find_by_vacancy_sended_professionals_id(params[:vacancy_sended_id])
    			if @vacancy_customer_interview.nil?
                    sended = VacancySendedProfessionals.find(params[:vacancy_sended_id])
    				@vacancy_customer_interview = VacancyCustomerInterview.new(
                        :vacancy_sended_professionals_id=> sended.id,
                        :vacancy_scheduling_professional_id=> sended.vacancy_scheduling_professional_id)
    			end
    			render :partial => "guara/jobs/vacancy_customer_interview/widget_form", :locals => { vacancy: @vacancy}
    		end

            def create

                vacancy_customer_interview = VacancyCustomerInterview.new(params[:jobs_vacancy_customer_interview])
                if vacancy_customer_interview.save
                    render :json => {:success=> true}
                else
                    render :json => {:data=> vacancy_customer_interview.errors, :success=> false} 
                end
            end

    		def update
    			@vacancy_customer_interview = VacancyCustomerInterview.find_by_vacancy_sended_professionals_id(params[:jobs_vacancy_customer_interview][:vacancy_sended_professionals_id])
                if @vacancy_customer_interview.nil?
                    self.create
                else
        			if @vacancy_customer_interview.update_attributes(params[:jobs_vacancy_customer_interview])
                		render :json => {:success=> true}
              		else
                		render :json => {:data=> @vacancy_customer_interview.errors, :success=> false} 
              		end
                end
    		end

    	end
    end
end