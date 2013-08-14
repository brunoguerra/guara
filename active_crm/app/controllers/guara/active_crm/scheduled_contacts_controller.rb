module Guara
  module ActiveCrm
  	class ScheduledContactsController < Guara::BaseController
    	skip_authorization_check

    	include ScheduledsHelper
        include ScheduledContactsHelper
        helper ScheduledContactsHelper

    	def index
    		params[:search] = {} if params[:search].nil?
    		scheduled_group = Scheduled::CustomerGroup.find(params[:scheduled_group_id])
    		search_params = prepare_filter_search(params[:search], scheduled_group)
    		
    		@search = Guara::Customer.customer_contact(params[:scheduled_group_id]).search(search_params)
        @customers_to_register = paginate(@search, params[:page], 40)

        @search_scheduled = Guara::Customer.customer_scheduled(params[:scheduled_group_id]).search(search_params)
        @customers_scheduled = @search_scheduled
    	end

      def new
          @contact = Guara::Contact.find(params[:contact_id])
          @scheduled_contact = Scheduled::Contact.new(contact_id: params[:contact_id], user_id: current_user.id)

          @deal = Guara::ActiveCrm::Scheduled::Deal.where(:customer_id=> @contact.person_id, :group_id=> params[:scheduled_group_id]).first

          render 'new.html.erb', layout: false
      end

      def create
          @scheduled_contact = Scheduled::Contact.new(params[:active_crm_scheduled_contact])
          @scheduled_contact.deal = create_deal(@scheduled_contact.contact.person_id, params[:scheduled_group_id])
          Scheduled::Contact.update_all("enabled = false ", "deal_id = #{@scheduled_contact.deal_id} AND contact_id = #{@scheduled_contact.contact_id} and enabled=true and result=#{Scheduled::Contact::SCHEDULED}")
          success = @scheduled_contact.save
          data = prepare_data_json()
          render :json => {success: success, data: data, errors: @scheduled_contact.errors }
      end

      def ignore_customer_session
          session[:ignored_customers] = [] if session[:ignored_customers].nil?
          session[:ignored_customers] << params[:customer_id] if !session[:ignored_customers].include?(params[:customer_id])
          render :json => {success: true}
      end

      def close_negociation
          deal = Scheduled::Deal.where(:customer_id=> params[:customer_id], :group_id=> params[:group]).first
          deal = create_deal(params[:customer_id], params[:group]) if deal.nil?
          deal.update_attributes(:closed=> true, :date_finish=> Time.now)
          render :json => { success: true}
      end

      private
      
        def prepare_data_json
            data = @scheduled_contact.attributes
            data["customer_name"] = @scheduled_contact.contact.customer.name
            data["customer_id"] = @scheduled_contact.contact.customer.id
            data["contact_name"] = @scheduled_contact.contact.name
            data["scheduled"] = @scheduled_contact.scheduled.nil? ? '' : @scheduled_contact.scheduled.strftime("%d/%m/%Y %H:%M")
            data["status"] = prepare_span_status(@scheduled_contact)
            return data
        end

        def create_deal(customer_id, group_id)
          deal = Guara::ActiveCrm::Scheduled::Deal
          .where(:customer_id=> customer_id, :group_id=> group_id).first
          
          if deal.nil?
            deal = Guara::ActiveCrm::Scheduled::Deal.create(
              :customer_id=> customer_id, 
              :date_start=> Time.now, 
              :group_id=> group_id
            )
          end

          deal
        end
    
	  end
  end
end