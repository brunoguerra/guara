
module Guara
  	module ActiveCrm
    	class ScheduledCustomerGroupsController < Guara::BaseController
    		skip_authorization_check
    		
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
    		end

            def create
                @scheduled_customer_group = ScheduledCustomerGroup.new(prepare_filter_save(params[:search], params[:scheduled_id))

                respond_to do |format|
                  if @scheduled_customer_group.save
                    format.html { redirect_to scheduled_scheduled_customer_group_path(params[:scheduled_id], @scheduled_customer_group), notice: 'Scheduled Customer Group created.' }
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