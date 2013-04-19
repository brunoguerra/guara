module Guara
  module Jobs
    class VacancySendedProfessionalsController < BaseController
    	load_and_authorize_resource :vacancy, :class => "Guara::Jobs::Vacancy", :except => [:show_pdf_professional]
      load_and_authorize_resource :scheduling, through: :vacancy, :class => "Guara::Jobs::VacancySchedulingProfessional", :except => [:show_pdf_professional]
      load_and_authorize_resource :sended, :class => "Guara::Jobs::VacancySendedProfessionals", :except => [:show_pdf_professional]
      include ::Guara::Jobs::ActiveProcess::ProcessStepComponent
      
      def initialize()
        @widget_request = true
      end

    	def load_selecteds_professionals()
        @vacancy      = @vacancy || Vacancy.find_by_process_instance_id(params[:process_instance_id])
        @vacancy_scheduling_professionals = VacancySchedulingProfessional.find(:all, :conditions=> ["vacancy_id = ? AND interested = true ", @vacancy.id], :order=> "avaliate DESC")
			  @unscheduleds = VacancySendedProfessionals.unsended_professionals(@vacancy_scheduling_professionals)
	      @scheduleds   = VacancySendedProfessionals.sended_professionals(@vacancy_scheduling_professionals)
	    end

    	def index
    		load_selecteds_professionals

        if @widget_request
          render :partial => "guara/jobs/vacancy_sended_professionals/widget_index", :locals => { vacancy: @vacancy}
        else        
          respond_to do |format|
            format.html { render :index }
            format.json { render json: [@unscheduled_professionals, @scheduled_professionals] }
          end
        end
    	end

      def create
        @vacancy_sended_professional = VacancySendedProfessionals.new(:date=> Time.now, :vacancy_scheduling_professional_id=> params[:vacancy_scheduling_professionals_id])
        
        if @vacancy_sended_professional.save
          render :json => {:data=> @vacancy_sended_professional, :success=> true}
        else
          render :json => {:data=> @vacancy_sended_professional.errors, :success=> false} 
        end
      end

      def show
        load_selecteds_professionals
        render :partial => "guara/jobs/vacancy_sended_professionals/widget_show"
      end

      def destroy
        @vacancy_sended_professional = VacancySendedProfessionals.destroy_all(['vacancy_scheduling_professional_id = ?', params[:vacancy_scheduling_professionals_id]])
        
        @vacancy_scheduling_professional = VacancySchedulingProfessional.find params[:vacancy_scheduling_professionals_id]
        
        res = @vacancy_scheduling_professional.attributes
        res[:professional] = @vacancy_scheduling_professional.professional.person.attributes
        res[:consultant] = @vacancy_scheduling_professional.consultant.attributes
        res[:interview] = @vacancy_scheduling_professional.interview.attributes
        res[:avaliate] = Guara::Jobs::LevelAvaliation.levels_translated()[@vacancy_scheduling_professional.avaliate]

        if @vacancy_sended_professional
          render :json => {:data=> res, :success=> true}
        else
          render :json => {:data=> @vacancy_sended_professional.errors, :success=> false} 
        end        
      end

      def load_customer_pj(process_instance_id)
        step_attr = Guara::Jobs::ProcessInstance.find(process_instance_id).custom_process
          .step.attrs.where("options ILIKE '%Guara::CustomerPj'").last()

        customer_pj_id = Guara::Jobs::StepInstanceAttr
          .where(:step_attr_id=> step_attr.id, :process_instance_id=> params[:process_instance_id])
          .last().values.last().value

          return Guara::Customer.find(customer_pj_id)
      end

      def send_email_customer_pj
        @customer_pj = load_customer_pj(params[:process_instance_id])
        load_selecteds_professionals
        VacancySendedProfessionalsMailer.professionals_email({
          :customer_pj=> @customer_pj,
          :vacancy_scheduling_professionals=> @unscheduleds
        }).deliver
        render :json => {:success=> true}
      end

      def show_pdf_professional
        authorize! Guara::Jobs::Professional, :read
        
        scheduling = VacancySchedulingProfessional.find(params[:scheduling_id])
        filename = "#{scheduling.vacancy_id}_#{scheduling.professional_id}.pdf"
        path_pdf  = Rails.root.join('../guara/jobs/lib/guara/jobs/vacancy_sended_professionals_pdf', filename)
        send_file(path_pdf, :type => "application/pdf",
            :filename => filename, :disposition => "inline")
      end

    end
  end
end    
