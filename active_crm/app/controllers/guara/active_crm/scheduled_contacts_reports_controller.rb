module Guara
  	module ActiveCrm
    	class ScheduledContactsReportsController < Guara::BaseController
    		load_and_authorize_resource :scheduled_contacts_repost, :class => "Guara::ActiveCrm::Scheduled::Deals", except: [:multiselect_scheduleds, :multiselect_group, :index]

    		include Select2Helper
    		include ScheduledsHelper
            include ScheduledContactsHelper

            helper ScheduledsHelper
            helper ScheduledContactsHelper

    		def index
    			params[:search] = {} if params[:search].nil?
    			@deals = Scheduled::Deals.select("#{Scheduled::Contact.table_name}.*")
				.joins(:contacts)

				@scheduled_deals = @search = @deals.search(params[:search])

    			load_selects
    			authorize! :read, Guara::ActiveCrm::Scheduled::Deals

    			respond_to do |format|
			      format.html
			      format.pdf do
			        render :pdf => "index"
			      end
			    end
    		end

    		private
    		def load_selects
    			@scheduleds 		= load_scheduleds_select(params[:search])
                @customer_groups	= load_group_select(params[:search])
                @customers 			= load_customer_select(params[:search])
    		end
    	end
    end
end