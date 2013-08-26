module Guara
  	module ActiveCrm
    	class ScheduledDealsController < Guara::BaseController
    		load_and_authorize_resource :scheduled_deal, :class => "Guara::ActiveCrm::Scheduled::Deal", except: [:multiselect_scheduleds, :multiselect_group]

    		include ScheduledsHelper
            include ScheduledContactsHelper

            helper ScheduledsHelper
            helper ScheduledContactsHelper

    		def index
    			params[:search] = {} if params[:search].nil?
                @search = Scheduled::Deal.search(params[:search])
                @scheduled_deals = paginate(@search)
                @scheduleds = load_scheduleds_select(params[:search])
                @groups = load_group_select(params[:search])
                @customers = load_customer_select(params[:search])
    		end

            def show
                @scheduled_deal = Scheduled::Deal.find(params[:id])
                @active_crm_scheduled = @scheduled_deal.group.scheduled
                @groups = [@scheduled_deal.group]
                
                if params[:layout]=="false"
                    render :layout => false
                else
                    render
                end
            end

    		def multiselect_scheduleds
    			@scheduleds = load_scheduleds_select(params[:search])
    			render json: {success: true, data: @scheduleds.collect { |c| { :id => c.id.to_s, :name => c.name } } }

                authorize! :read, Scheduled::Scheduled
    		end

            def multiselect_group
                @groups = Scheduled::Group.where(:scheduled_id=> params[:scheduled_id])
                render json: {success: true, data: @groups.collect { |c| { :id => c.id.to_s, :name => c.name } } }

                authorize! :read, Scheduled::Group 
            end

    	end
    end
end