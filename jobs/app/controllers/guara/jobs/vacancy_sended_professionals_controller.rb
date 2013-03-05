module Guara
  module Jobs
    class VacancySendedProfessionalsController < BaseController
    	load_and_authorize_resource :vacancy, :class => "Guara::Jobs::Vacancy"
      load_and_authorize_resource :scheduling, through: :vacancy, :class => "Guara::Jobs::VacancySchedulingProfessional"
      load_and_authorize_resource :sended, :class => "Guara::Jobs::VacancySendedProfessionals"
      include ::Guara::Jobs::ActiveProcess::ProcessStepComponent
      
      def initialize()
        @widget_request = true
      end

    	def load_selecteds_professionals()
        @vacancy      = @vacancy || Vacancy.find_by_process_instance_id(params[:process_instance_id])
        @vacancy_scheduling_professionals = VacancySchedulingProfessional.find(:all, :conditions=> ["vacancy_id = ? ", @vacancy.id], :order=> "avaliate DESC")
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
        
      end

      def destroy
        @vacancy_sended_professional = VacancySendedProfessionals.destroy_all(['vacancy_scheduling_professional_id = ?', params[:vacancy_scheduling_professionals_id]])
        
        @vacancy_scheduling_professional = VacancySchedulingProfessional.find params[:vacancy_scheduling_professionals_id]
        
        res = @vacancy_scheduling_professional.attributes
        res[:professional] = @vacancy_scheduling_professional.professional.person.attributes
        res[:consultant] = @vacancy_scheduling_professional.consultant.attributes
        res[:avaliate] = Guara::Jobs::LevelAvaliation.levels_translated()[@vacancy_scheduling_professional.avaliate]

        if @vacancy_sended_professional
          render :json => {:data=> res, :success=> true}
        else
          render :json => {:data=> @vacancy_sended_professional.errors, :success=> false} 
        end        
      end


    end
  end
end    
