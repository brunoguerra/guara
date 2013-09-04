module Guara
  module ActiveCrm
  	class ScheduledContactsController < Guara::BaseController
    	load_and_authorize_resource :class => "Guara::ActiveCrm::Scheduled::Contact", :except => [:close_negociation, :next_customer, :ignore_customer, :update_activity]

    	include ScheduledsHelper
      include ScheduledContactsHelper
      helper ScheduledContactsHelper

      before_filter :load_group, :only => [:index, :new, :create, :close_negociation, :next_customer, :ignore_customer, :update_activity]

    	def index
    		params[:search] = {} if params[:search].nil?
    		search_params = prepare_filter_search(params[:search], @group)
    		
    		@search = @group.to_contact
        @customers_to_register = paginate(@search, params[:page], 40)

        @customers_scheduled = @group.scheduled_contacts.order('scheduled_at asc')
        @ignored_customers = paginate(@group.ignored.order('created_at desc'), params[:ignored_page], 40)
        @deals = @group.deals

    	end

      def new
          @contact = Guara::Contact.find(params[:contact_id])
          @deal = @group.find_or_create_deal(@contact.person)
          @scheduled_contact = Scheduled::Contact.new(contact_id: @contact.id, deal_id: @deal.id, user_id: current_user.id)

          render 'new', layout: false, formats: [:html]
      end

      def create
          @contact = Guara::Contact.find(params[:active_crm_scheduled_contact][:contact_id])
          @deal = @group.find_or_create_deal(@contact.person)
          @scheduled_contact = Scheduled::Contact.new(params[:active_crm_scheduled_contact])
          @scheduled_contact.deal = @deal

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
          authorize! :update, Guara::ActiveCrm::Scheduled::Deal
      end

      def next_customer
        scheduled = @group.expired_contacts.order(:scheduled_at).first
        @data = { index: params[:index].to_i+1 }
        #
        if (scheduled.nil?)
            c_next = next_to_contact
            @data[:next] = { customer_id: c_next.id } unless c_next.nil?
        else
            @data[:scheduled] = {
                customer_id: scheduled.deal.customer_id,
                contact_id: scheduled.contact_id,
            }
        end

        authorize! :read, Guara::ActiveCrm::Scheduled::Group
        render :json => @data
      end

      def ignore_customer
        authorize! :update, Guara::ActiveCrm::Scheduled::Group
        customer = Guara::Customer.find params[:customer_id]
        Scheduled::Ignored.create!(customer_id: customer.id, group_id: @group.id)
        next_customer
        authorize! :read, Guara::ActiveCrm::Scheduled::Group
      end

      def update_activity
        @scheduled_contact = Scheduled::Contact.find params[:scheduled_contact_id]
        @scheduled_contact.update_attribute(:activity, params[:activity])
        render :json => @scheduled_contact.as_json(:only => [:id, :activity]).merge({:success => true})
        authorize! :read, Guara::ActiveCrm::Scheduled::Group
      end

      private
      
        def prepare_data_json
            data = @scheduled_contact.attributes
            data[:scheduled_at] = @scheduled_contact.scheduled_at.in_time_zone.to_s unless @scheduled_contact.scheduled_at.nil?
            data[:created_at] = @scheduled_contact.created_at.to_s
            data[:updated_at] = @scheduled_contact.updated_at.to_s
            data["customer_name"] = @scheduled_contact.contact.customer.name
            data["customer_id"] =   @scheduled_contact.contact.customer.id
            data["contact_name"] =  @scheduled_contact.contact.name
            data["scheduled"] =     @scheduled_contact.scheduled_at.to_s.empty? ? '' : @scheduled_contact.scheduled_at.strftime("%d/%m/%Y %H:%M")
            data["status"] =        prepare_span_status(@scheduled_contact)
            unless @scheduled_contact.deal.nil?
              @deal = @scheduled_contact.deal
              data["deal"] = {
                id:                       @deal.id,
                created_at:               @deal.created_at.in_time_zone.to_s,
                date_start:               @deal.date_start.in_time_zone.to_s,
                customer_name:            @deal.customer.name,
                accepted_total:           @deal.accepted_total,
                scheduled_contacts_total: @deal.scheduled_contacts_total,
                contacts_total:           @deal.contacts.count
              }
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

        def next_to_contact
            if (params[:index].to_i>-1)
              index = params[:index].to_i + 1
              @group.to_contact.paginate(page: index, per_page: 1).reorder("guara_people.id asc").first
            else
              @group.to_contact.first
            end
        end
	  end
  end
end