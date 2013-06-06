
module Guara
  	module ActiveCrm
    	class ScheduledContactsController < Guara::BaseController
    		skip_authorization_check

    		include ScheculedsHelper

    		def index
    			params[:search] = {} if params[:search].nil?
    			scheduled_customer_group = ScheduledCustomerGroup.find_by_scheduled_id(params[:scheduled_id])
    			search = prepare_filter_search(params[:search], scheduled_customer_group)
    			
    			@search = Guara::Customer.verify_scheduled(params[:scheduled_id], '=').search(search)
                @search_scheduled = Guara::Customer.verify_scheduled(params[:scheduled_id], '>').search(search)

                @customers_to_register = paginate(@search)
                @customers_scheduled = paginate(@search_scheduled)
    		end

    	end
    end
end