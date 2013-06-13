module Guara
  	module ActiveCrm
    	class ScheduledDealsController < Guara::BaseController
    		load_and_authorize_resource :scheduled_deal, :class => "Guara::ActiveCrm::Scheduled::Deals", except: [:multiselect_scheduleds, :multiselect_group]

    		include ScheculedsHelper
            include ScheduledContactsHelper

            helper ScheculedsHelper
            helper ScheduledContactsHelper

    		def index
    			params[:search] = {} if params[:search].nil?
                @search = Scheduled::Deals.search(params[:search])
                @scheduled_deals = paginate(@search)
                @scheduleds = load_scheduleds_select
                @customer_groups = load_group_select
    		end

            def show
                @scheduled_deal = Scheduled::Deals.find(params[:id])
                @active_crm_scheduled = @scheduled_deal.group.scheduled
                @customer_groups = [@scheduled_deal.group]
            end

    		def multiselect_scheduleds
    			@scheduleds = load_scheduleds_select
    			render json: {success: true, data: @scheduleds.collect { |c| { :id => c.id.to_s, :name => c.name } } }

                authorize! :read, Scheduled::Scheduled
    		end

            def multiselect_group
                @groups = Scheduled::CustomerGroup.where(:scheduled_id=> params[:scheduled_id])
                render json: {success: true, data: @groups.collect { |c| { :id => c.id.to_s, :name => c.name } } }

                authorize! :read, Scheduled::CustomerGroup 
            end

    		private
    		def load_scheduleds_select
    			search = search_scheduled(params[:search])
                if search.empty?
                	return Scheduled::Scheduled.limit(25).search(search).order(:id)
                else
                	return Scheduled::Scheduled.search(search).order(:id)
                end
    		end

            private
            def load_group_select
                if params[:search][:group_scheduled_id_in].nil?
                    return Scheduled::CustomerGroup.order(:id).limit(25)
                else
                    return Scheduled::CustomerGroup.where(:scheduled_id=> params[:search][:group_scheduled_id_in]).order(:id).limit(25)
                end
            end

    	end
    end
end