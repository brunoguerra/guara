
module ActiveCrm

  class ContactCustomersPageUtil < Struct.new(:group, :user)
    include Capybara::DSL

    TO_CONTACT_LIST = '#active_crm.scheduled_contacts .customers table'

    SHOW_CUSTOMER_SECTION = 'section#customer_show'

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
        find SHOW_CUSTOMER_SECTION
      end

      def routes
        Guara::Core::Engine.routes.url_helpers
      end 

  end

  # < ========================================
  # Class Thing On The Page
  ##
  ###
  class CustomerOnContactCustomersPage
    attr_accessor :page, :customer

    include Capybara::DSL
    include Guara::TestSupport::Utilities

    def initialize(page, customer)
      self.page, self.customer = page, customer
    end

    def contactable?
      page.to_contact_list.has_css? "tr[customer-id='#{customer.id}']"
    end

    def visible?
      page.show_customer_section.has_css? "h2.modules", text: /#{customer.name}/i
    end

    def click
      page.to_contact_list.find("tr[customer-id='#{customer.id}']").click
    end

    def have(number)
      @records_to_create = number
    end

    def contacts_list
      find 'li.container.container-contacts'
    end

    def contacts
      if (@records_to_create>0)
        customer.contacts << Array.new() { FactoryGirl.create(:contact, customer: customer) }
        @records_to_create=0
      end
      customer.contacts
    end

    def contact_on_page(contact=nil)
      @contact_on_page ||= ContactOnContactCustomersPage.new(page, self, contact || customer.contacts.first)
    end

    def deal_on_page
      @deal ||= Deal.find()
      @deal_on_page ||= DealOnContactCustomersPage.new(contact_on_page.customer_on_page, )
    end
  end

  # < ========================================
  # Class Thing On The Page
  ##
  ###
  class ContactOnContactCustomersPage
    attr_accessor :page, :customer_on_page, :contact

    def initialize(page, customer_on_page, contact)
      self.page = page
      self.customer_on_page = customer_on_page
      self.contact = contact
    end

    def click
      customer_on_page.contacts_section.find("tr[contact-id='#{contact.id}']").click
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
    attr_accessor :contact_on_page, :params

    FORM_ELEMENT = '.scheduled_contact_submit'
    BUTTON_SUBMIT_ELEMENT = 'button.btn-submit'

    def initialize(contact_on_page, result = ActiveCrm::Scheduled::Contact::ACCEPTED)
      self.contact_on_page = contact_on_page

      @params = {
        activity: "Contact by phone result",
        result: result,
      }
    end

    def form
      find FORM_ELEMENT
    end

    def create
      fill_in I18n.t('active_crm.scheduled.activity'), with: @params[:activity]
      click_on_type @params[:result]
      form.find(BUTTON_SUBMIT_ELEMENT).click
    end

    def click_on_type(result)
      case result
      when ActiveCrm::Scheduled::Contact::ACCEPTED
        click_link I18n.t("active_crm.results_translated.registered")
      when ActiveCrm::Scheduled::Contact::ACCEPTED
        click_link I18n.t("active_crm.results_translated.participation_denied")
      when ActiveCrm::Scheduled::Contact::ACCEPTED
        click_link I18n.t("active_crm.results_translated.scheduling")
      end
    end
  end

  # < ========================================
  # Class Thing On The Page
  ##
  ###
  class DealOnContactCustomersPage
    attr_accessor :customer_on_page, :page, :deal

    DEAL_LIST_ELEMENT = '.deal.list'

    def initialize(customer_on_page, deal)
      self.customer_on_page = customer_on_page
      self.page = self.customer_on_page.page
      self.deal = deal
    end

    def list
      page.find DEAL_LIST_ELEMENT
    end

    def visible?
      page.find(DEAL_LIST_ELEMENT).has_css? "tr[deal-id='#{deal.id}']"
    end
    
  end

  ###
  ##
  # ======================================== >
end