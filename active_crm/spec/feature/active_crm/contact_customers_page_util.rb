module Guara
  module ActiveCrm

    class ContactCustomersPageUtil < Struct.new(:page, :group, :user)
      include Capybara::DSL

      TO_CONTACT_LIST = '#active_crm.scheduled_contacts #customer-to-register'
      SHOW_CUSTOMER_SECTION = 'section#customer_show'
      DEALS_LIST_ELEMENT = '.deal.list'

      def loader
        find '#loader'
      end

      def wait_for_ajax
        t1 = Time.now
        has_selector?('body.ajaxCompleted')
        puts "waiting for ajax #{(Time.now - t1)*1000}\n\n\n"
      end

      def customer_on_page(customer)
        CustomerOnContactCustomersPage.new(self, customer)
      end

      def show_group
        visit routes.scheduled_scheduled_group_scheduled_contacts_path(group.scheduled.id, group.id)
      end

      def create
        click_link 'Create a new todo'
        fill_in 'Title', with: title
        click_button 'Create'
      end


      public
        def to_contact_list
          find TO_CONTACT_LIST
        end

        def show_customer_section
          has_css? SHOW_CUSTOMER_SECTION
          find SHOW_CUSTOMER_SECTION
        end

        def routes
          Guara::Core::Engine.routes.url_helpers
        end 

        def deals_list
          find DEALS_LIST_ELEMENT
        end

    end

    # < ========================================
    # Class Thing On The page_util
    ##
    ###
    class CustomerOnContactCustomersPage
      attr_accessor :page_util, :customer

      include Capybara::DSL
      include Guara::TestSupport::Utilities

      def initialize(page_util, customer)
        self.page_util, self.customer = page_util, customer
      end

      def contactable?
        page_util.to_contact_list.has_css? "tr[customer-id='#{customer.id}']"
      end

      def visible?
        page_util.show_customer_section.has_css? "h2.modules", text: /#{customer.name}/i
      end

      def click
        page_util.to_contact_list.find("tr[customer-id='#{customer.id}']").click
      end

      def have(number)
        @records_to_create = number
        self
      end

      def contacts_list
        find 'li.container.container-contacts'
      end

      def contacts
        if (@records_to_create>0)
          customer.contacts += Array.new(@records_to_create) { FactoryGirl.create(:contact, customer: customer) }
          @records_to_create=0        
        end
        customer.contacts
      end

      def contact_on_page(contact=nil)
        @contact_on_page ||= ContactOnContactCustomersPage.new(page_util, self, contact || customer.contacts.first)
      end

    end

    # < ========================================
    # Class Thing On The Page
    ##
    ###
    class ContactOnContactCustomersPage
      attr_accessor :page_util, :customer_on_page, :contact

      def initialize(page_util, customer_on_page, contact)
        self.page_util = page_util
        self.customer_on_page = customer_on_page
        self.contact = contact
      end

      def click
        customer_on_page.contacts_list.find("tr[contact-id='#{contact.id}']").click
      end

      def contact_by_phone
        @contact_by_phone ||= ContactByPhoneOnContactCustomersPage.new(self)
      end
    end

    # < ========================================
    # Class Thing On The Page
    ##
    ###
    class ContactByPhoneOnContactCustomersPage
      attr_accessor :contact_on_page, :params, :page_util

      include Capybara::DSL

      FORM_ELEMENT = ContactCustomersPageUtil::SHOW_CUSTOMER_SECTION + ' #index.tab-pane #scheduled_contact_form'
      BUTTON_SUBMIT_ELEMENT = 'button.btn-submit'

      def initialize(contact_on_page, result = Scheduled::Contact::ACCEPTED)
        self.contact_on_page = contact_on_page
        self.page_util = contact_on_page.page_util

        @params = {
          activity: "Contact by phone result",
          result: result,
        }
      end

      def form
        find FORM_ELEMENT
      end

      def create
        within FORM_ELEMENT do
          fill_in I18n.t('scheduleds.activity'), with: @params[:activity]
          click_on_type @params[:result]
          find(BUTTON_SUBMIT_ELEMENT).click
        end
      end

      def click_on_type(result)
        case result
        when Scheduled::Contact::ACCEPTED
          click_link I18n.t("scheduleds.contacts.result.accepted")
        when Scheduled::Contact::ACCEPTED
          click_link I18n.t("scheduleds.contacts.result.denied")
        when Scheduled::Contact::ACCEPTED
          click_link I18n.t("scheduleds.contacts.result.scheduled")
        end
      end

      def deal_on_page
        has_css?('[deal-id]') #prevents loading ajax
        @deal ||= Scheduled::Deal.where(customer_id: contact_on_page.customer_on_page.customer.id,
                            scheduled_id: contact_on_page.page_util.group.scheduled.id).first
        raise "Recorded Deal not found" if @deal.nil?

        @deal_on_page ||= DealOnContactCustomersPage.new(contact_on_page.customer_on_page, @deal)
      end
    end

    # < ========================================
    # Class Thing On The Page
    ##
    ###
    class DealOnContactCustomersPage
      include Capybara::DSL
      
      attr_accessor :customer_on_page, :page_util, :deal

      def initialize(customer_on_page, deal)
        self.customer_on_page = customer_on_page
        self.page_util = self.customer_on_page.page_util
        self.deal = deal
      end

      def visible?
        page_util.deals_list.has_css? "tr[deal-id='#{deal.id}']"
      end
      
    end

    ###
    ##
    # ======================================== >
  end
end