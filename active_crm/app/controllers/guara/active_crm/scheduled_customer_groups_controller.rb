
module Guara
  	module ActiveCrm
    	class ScheduledCustomerGroupsController < Guara::BaseController
    		load_and_authorize_resource :scheduled_customer_group, :class => "Guara::ActiveCrm::ScheduledCustomerGroup", :except => [:index, :create]
    		
            include Select2Helper
            include ScheculedsHelper

    		def index
    			params[:search] = {} if params[:search].nil?
                filter_multiselect params[:search], :customer_guara_customer_pj_type_activities_business_segment_id_in
                filter_multiselect params[:search], :customer_guara_customer_pj_type_activities_id_in
                @search = Guara::Customer.verify_scheduled(params[:scheduled_id], '=').search(params[:search])
                @search_scheduled = Guara::Customer.verify_scheduled(params[:scheduled_id], '>').search(params[:search])

                @customers_to_register = paginate(@search)
                @customers_scheduled = paginate(@search_scheduled)

                respond_to do |format|
                    format.html
                    format.js{ render 'index.js.erb' }
                end

                authorize! :read, Guara::ActiveCrm::ScheduledCustomerGroup
    		end

            def create
                @scheduled_customer_group = Guara::ActiveCrm::ScheduledCustomerGroup.new(prepare_filter_save(params[:search], params[:scheduled_id]))
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
    	end
	end
end