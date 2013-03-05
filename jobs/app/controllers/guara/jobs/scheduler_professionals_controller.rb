module Guara
  module Jobs
    class SchedulerProfessionalsController < BaseController
      load_and_authorize_resource :vacancy, :class => "Guara::Jobs::Vacancy"
      load_and_authorize_resource :scheduling, through: :vacancy, :class => "Guara::Jobs::VacancySchedulingProfessional"
      include ::Guara::Jobs::ActiveProcess::ProcessStepComponent
      
      def initialize()
        @widget_request = true
      end
      
      def load_selecteds_professionals()
        @vacancy      = @vacancy || Vacancy.find_by_process_instance_id(params[:process_instance_id])
        
        @unscheduleds = VacancySchedulingProfessional.unscheduled_professionals(@vacancy)
        @scheduleds   = VacancySchedulingProfessional.scheduled_professionals(@vacancy)
      end
      
      def index
        load_selecteds_professionals()
        
        if @widget_request
          render :partial => "guara/jobs/scheduler_professionals/widget_index", :locals => { vacancy: @vacancy}
        else        
          respond_to do |format|
            format.html { render :index }
            format.json { render json: [@unscheduled_professionals, @scheduled_professionals] }
          end
        end
      end
      
      def show()
        
      end
      
      def new()
        @vacancy_scheduling = VacancySchedulingProfessional.new
        if @widget_request
          render :partial => "guara/jobs/scheduler_professionals/widget_new", :locals => { vacancy: @vacancy}
        else
          render
        end
      end
      
      def create()
        @vacancy_scheduling = VacancySchedulingProfessional.new(params[:jobs_vacancy_scheduling_professional])

        if @vacancy_scheduling.save
          render :json => {:data=> @vacancy_scheduling, :success=> true}
        else
          render :json => {:data=> @vacancy_scheduling.errors, :success=> false} 
        end
      end
      
      def edit()
        @vacancy_scheduling = VacancySchedulingProfessional.find(:first, :conditions=> ['vacancy_id = ? AND professional_id = ?', params[:vacancy_id], params[:professional_id]])
        if @widget_request
          render :partial => "guara/jobs/scheduler_professionals/widget_edit", :locals => { vacancy: @vacancy}
        else
          render
        end
      end
      
      def update()
        
      end

      def destroy()
        @a = params[:jobs_vacancy_scheduling_professional]
        @vacancy_scheduling = VacancySchedulingProfessional.destroy_all(['vacancy_id = ? AND professional_id = ?', @a[:vacancy_id], @a[:professional_id]])
        if @vacancy_scheduling
          render :json => {:data=> @a, :success=> true}
        else
          render :json => {:data=> @vacancy_scheduling.errors, :success=> false} 
        end
      end
         
    end
    
  end
end