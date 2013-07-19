module Guara
  module ActiveCrm
    class ScheduledsController < Guara::BaseController
      load_and_authorize_resource :scheduled, :class => "Guara::ActiveCrm::Scheduled", :except => [:index, :new, :create, :show, :edit, :update]
      
      include Select2Helper
      helper ScheduledsHelper
      helper TasksHelper
      
      def index
        param_search = params[:search]

        if !param_search.nil? && param_search.size>0 
          filter_multiselect param_search, :user_id_in
          filter_multiselect param_search, :task_type_id_in
        end

        @search = ActiveCrm::Scheduled::Scheduled.search(param_search)
        @active_crm_scheduleds = paginate(@search,  params[:page], 4)

        @scheduled = ActiveCrm::Scheduled::Scheduled.new(:user_id=> current_user.id, status: 0)
    
        respond_to do |format|
          format.html do
            #
          end

          format.json do
            render json: @active_crm_scheduled
          end
        end

        authorize! :read, @active_crm_scheduleds
      end
          
      def show
        @active_crm_scheduled = ActiveCrm::Scheduled::Scheduled.find(params[:id])
        @customer_groups = @active_crm_scheduled.customer_group

        respond_to do |format|
          format.html
          format.json do
            render json: @active_crm_scheduled 
          end
        end

        authorize! :read, @active_crm_scheduled
      end
    
      def new
        @scheduled = ActiveCrm::Scheduled::Scheduled.new(:user_id=> current_user.id, status: 0)

        respond_to do |format|
          format.html
          format.json { render json: @scheduled }
        end

        authorize! :create, ActiveCrm::Scheduled::Scheduled
      end
    
      def edit
        @scheduled = Scheduled::Scheduled.find(params[:id])
        authorize! :update, @active_crm_scheduled
      end
    
      def create
        @active_crm_scheduled = ActiveCrm::Scheduled::Scheduled.new(params[:active_crm_scheduled_scheduled])
        authorize! :create, @active_crm_scheduled

        respond_to do |format|
          if @active_crm_scheduled.save
            format.html { redirect_to scheduled_path(@active_crm_scheduled), notice: t("active_crm.scheduled.successfully_save") }
            format.json { render json: scheduled_path(@active_crm_scheduled), status: :created, location: @active_crm_scheduled }
          else
            format.html { render action: "new" }
            format.json { render json: @active_crm_scheduled.errors, status: :unprocessable_entity }
          end
        end
      end
    
      def update
        @active_crm_scheduled = ActiveCrm::Scheduled::Scheduled.find(params[:id])
    
        respond_to do |format|
          if @active_crm_scheduled.update_attributes(params[:active_crm_scheduled_scheduled])
            format.html { redirect_to scheduled_path(@active_crm_scheduled), notice: t("active_crm.scheduled.successfully_update") }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @active_crm_scheduled.errors, status: :unprocessable_entity }
          end
        end

        authorize! :read, @active_crm_scheduled
      end
    
      def destroy
        @active_crm_scheduled = ActiveCrm::Scheduled::Scheduled.find(params[:id])
        @active_crm_scheduled.destroy
    
        respond_to do |format|
          format.html { redirect_to scheduleds_url }
          format.json { head :no_content }
        end
      end

    end
  end
end
