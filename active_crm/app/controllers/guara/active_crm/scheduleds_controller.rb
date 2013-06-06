module Guara
  module ActiveCrm
    class ScheduledsController < Guara::BaseController
      load_and_authorize_resource :custom_process, :class => "Guara::ActiveCrm::Scheduled", :except => [:index, :new]
      
      def index
        @search = ActiveCrm::Scheduled.search(params[:search])
        @active_crm_scheduleds = paginate(@search)
        params[:search] = {} if params[:search].nil?
    
        respond_to do |format|
          format.html 
          format.json { render json: @active_crm_scheduleds }
        end

        authorize! :read, @active_crm_scheduleds
      end
    
      def show
        @active_crm_scheduled = ActiveCrm::Scheduled.find(params[:id])
    
        respond_to do |format|
          format.html
          format.json { render json: @active_crm_scheduled }
        end
      end
    
      def new
        @scheduled = ActiveCrm::Scheduled.new
        respond_to do |format|
          format.html
          format.json { render json: @scheduled }
        end

        authorize! :create, ActiveCrm::Scheduled
      end
    
      def edit
        @scheduled = ActiveCrm::Scheduled.find(params[:id])
      end
    
      def create
        @scheduled = ActiveCrm::Scheduled.new(params[:active_crm_scheduled])
    
        respond_to do |format|
          if @active_crm_scheduled.save
            format.html { redirect_to @active_crm_scheduled, notice: 'Scheduled was successfully created.' }
            format.json { render json: @active_crm_scheduled, status: :created, location: @active_crm_scheduled }
          else
            format.html { render action: "new" }
            format.json { render json: @active_crm_scheduled.errors, status: :unprocessable_entity }
          end
        end
      end
    
      def update
        @active_crm_scheduled = ActiveCrm::Scheduled.find(params[:id])
    
        respond_to do |format|
          if @active_crm_scheduled.update_attributes(params[:active_crm_scheduled])
            format.html { redirect_to @active_crm_scheduled, notice: 'Scheduled was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @active_crm_scheduled.errors, status: :unprocessable_entity }
          end
        end
      end
    
      def destroy
        @active_crm_scheduled = ActiveCrm::Scheduled.find(params[:id])
        @active_crm_scheduled.destroy
    
        respond_to do |format|
          format.html { redirect_to scheduleds_url }
          format.json { head :no_content }
        end
      end
    end
  end
end
