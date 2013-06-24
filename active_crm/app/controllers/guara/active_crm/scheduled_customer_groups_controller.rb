
module Guara
  	module ActiveCrm
    	class ScheduledCustomerGroupsController < Guara::BaseController
    		load_and_authorize_resource :scheduled_customer_group, :class => "Guara::ActiveCrm::Scheduled::CustomerGroup", :except => [:index, :create]
    		
            include Select2Helper
            include ScheduledsHelper

    		def index
    			params[:search] = {} if params[:search].nil?
                filter_multiselect params[:search], :customer_guara_customer_pj_type_activities_business_segment_id_in
                filter_multiselect params[:search], :customer_guara_customer_pj_type_activities_id_in
                @search = Guara::Customer.customer_contact(params[:scheduled_id]).search(params[:search])
                @customers_to_register = paginate(@search)

                respond_to do |format|
                    format.html
                    format.js{ render 'index.js.erb' }
                end

                authorize! :read, Guara::ActiveCrm::Scheduled::CustomerGroup
    		end

            def edit
                params[:search] = prepare_filter_search({}, Guara::ActiveCrm::Scheduled::CustomerGroup.find(params[:id])) if params[:search].nil?
                filter_multiselect params[:search], :customer_guara_customer_pj_type_activities_business_segment_id_in
                filter_multiselect params[:search], :customer_guara_customer_pj_type_activities_id_in
                
                @search = Guara::Customer.customer_contact(params[:scheduled_id]).search(params[:search])
                @customers_to_register = paginate(@search)

                respond_to do |format|
                    format.html{ render 'index.html.erb' }
                    format.js{ render 'index.js.erb' }
                end
            end

            def create
                @scheduled_customer_group = Guara::ActiveCrm::Scheduled::CustomerGroup.new(prepare_filter_save(params[:search], params[:scheduled_id]))
                authorize! :new, @scheduled_customer_group

                respond_to do |format|
                  if @scheduled_customer_group.save
                    format.html { redirect_to scheduled_path(params[:scheduled_id]) }
                    format.json { render json: @scheduled_customer_group, status: :created, location: @scheduled_customer_group }
                  else
                    format.html { render action: "new" }
                    format.json { render json: @scheduled_customer_group.errors, status: :unprocessable_entity }
                  end
                end
            end

            def update
                @scheduled_customer_group = Guara::ActiveCrm::Scheduled::CustomerGroup.find(params[:id])
                @scheduled_customer_group.update_attributes(prepare_filter_save(params[:search], params[:scheduled_id]))

                respond_to do |format|
                  if @scheduled_customer_group.save
                    format.html { redirect_to scheduled_path(params[:scheduled_id]) }
                    format.json { render json: @scheduled_customer_group, status: :updated, location: @scheduled_customer_group }
                  else
                    format.html { render action: "edit" }
                    format.json { render json: @scheduled_customer_group.errors, status: :unprocessable_entity }
                  end
                end
            end
    	end
	end
end