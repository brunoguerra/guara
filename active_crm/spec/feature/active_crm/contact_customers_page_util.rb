
module ActiveCrm

  class ContactCustomersPageUtil < Struct.new(:user)
    include Capybara::DSL

    TO_CONTACT_LIST = '#active_crm.scheduled_contacts .customers table'

    def select_to_contact(customer)
      whithin TO_CONTACT_LIST do
        click_on "tr[customer-id=#{customer.id}]"
      end
    end

    def create
      click_link 'Create a new todo'
      fill_in 'Title', with: title
      click_button 'Create'
    end


    private
      def to_contact_list
        find TO_CONTACT_LIST
      end


  end

  class CustomerOnContactCustomersPage
    attr_accessor :page

    def initialize(page)
      self.page = page
    end

  end
end