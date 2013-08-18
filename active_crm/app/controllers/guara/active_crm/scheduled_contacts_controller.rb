module Guara
  module ActiveCrm
  	class ScheduledContactsController < Guara::BaseController
    	skip_authorization_check

    	include ScheduledsHelper
      include ScheduledContactsHelper
      helper ScheduledContactsHelper

      before_filter :load_group, :only => [:index, :new, :create, :close_negociation]

    	def index
    		params[:search] = {} if params[:search].nil?
    		search_params = prepare_filter_search(params[:search], @group)
    		
    		@search = @group.to_contact
        @customers_to_register = paginate(@search, params[:page], 40)

        @customers_scheduled = @group.scheduled_contacts
        @deals = @group.deals
    	end

      def new
          @contact = Guara::Contact.find(params[:contact_id])
          @scheduled_contact = Scheduled::Contact.new(contact_id: @contact.id, user_id: current_user.id)

          @deal = Guara::ActiveCrm::Scheduled::Deal.where(:customer_id=> @contact.person_id, scheduled_id: @group.scheduled_id).first

          render 'new.html.erb', layout: false
      end

      def create
          @scheduled_contact = Scheduled::Contact.new(params[:active_crm_scheduled_contact])
          @scheduled_contact.group = @group

          success = @scheduled_contact.save
          render :json => {success: success, data: prepare_data_json(), errors: @scheduled_contact.errors }
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
            data["scheduled"] = @scheduled_contact.scheduled_at.to_s.empty? ? '' : @scheduled_contact.scheduled_at.strftime("%d/%m/%Y %H:%M")
            data["status"] = prepare_span_status(@scheduled_contact)
            unless @scheduled_contact.deal.nil?
              data["deal"] = @scheduled_contact.deal.as_json(
                                only: [
                                  :customer_name,
                                  :datetime, 
                                ],

                                root: false,
                              )
            end

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

        def load_group
          @group = Scheduled::Group.find params[:scheduled_group_id]
        end
    
	  end
  end
end