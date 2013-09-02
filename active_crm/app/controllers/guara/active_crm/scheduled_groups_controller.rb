
module Guara
  	module ActiveCrm
    	class ScheduledGroupsController < Guara::BaseController
    		load_and_authorize_resource :scheduled_group, :class => "Guara::ActiveCrm::Scheduled::Group", :except => [:index, :create]
    		
      include Select2Helper
      include ScheduledsHelper

  		def index
  			params[:search] = {} if params[:search].nil?
              filter_multiselect params[:search], :customer_guara_customer_pj_type_activities_business_segment_id_in
              filter_multiselect params[:search], :customer_guara_customer_pj_type_activities_id_in
              @search = Guara::Customer.search(params[:search])
              @customers_to_register = paginate(@search)

              respond_to do |format|
                  format.html
                  format.js{ render 'index.js' }
              end

              authorize! :read, Guara::ActiveCrm::Scheduled::Group
  		end

      def edit
          params[:search] = prepare_filter_search({}, Guara::ActiveCrm::Scheduled::Group.find(params[:id])) if params[:search].nil?
          filter_multiselect params[:search], :customer_guara_customer_pj_type_activities_business_segment_id_in
          filter_multiselect params[:search], :customer_guara_customer_pj_type_activities_id_in
          
          @search = Guara::Customer.search(params[:search])
          @customers_to_register = paginate(@search)

          respond_to do |format|
              format.html{ render 'index' }
              format.js{ render 'index.js' }
          end
      end

      def create
          @scheduled_group = Guara::ActiveCrm::Scheduled::Group.new(prepare_filter_save(params[:search], params[:scheduled_id]))
          authorize! :new, @scheduled_group

          respond_to do |format|
            if @scheduled_group.save
              format.html { redirect_to scheduled_path(params[:scheduled_id]) }
              format.json { render json: @scheduled_group, status: :created, location: @scheduled_group }
            else
              format.html { render action: "new" }
              format.json { render json: @scheduled_group.errors, status: :unprocessable_entity }
            end
          end
      end

      def update
          @scheduled_group = Guara::ActiveCrm::Scheduled::Group.find(params[:id])
          @scheduled_group.update_attributes(prepare_filter_save(params[:search], params[:scheduled_id]))

          respond_to do |format|
            if @scheduled_group.save
              format.html { redirect_to scheduled_path(params[:scheduled_id]) }
              format.json { render json: @scheduled_group, status: :updated, location: @scheduled_group }
            else
              format.html { render action: "edit" }
              format.json { render json: @scheduled_group.errors, status: :unprocessable_entity }
            end
          end
      end
    end
	end
end