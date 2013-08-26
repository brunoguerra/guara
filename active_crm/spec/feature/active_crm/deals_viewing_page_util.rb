module Guara
  module ActiveCrm
    class DealsViewingPageUtil < Struct.new(:page, :group, :user)
      include Capybara::DSL

      LIST_SELECTOR = '.deals.list'

      def self.instance(page, deal, user)
        @@instance ||= DealsPageUtil.new page, group, user
      end

      def show
        visit routes.scheduled_scheduled_group_scheduled_contacts_path(group.scheduled.id, group.id)
      end

      def list
        find LIST_SELECTOR
      end

      def deal_on_page
        DealOnPage.new self, Scheduled::Deal.first
      end

      def routes
        Guara::Core::Engine.routes.url_helpers
      end 

      def wait_for_element(element)
        t1 = Time.now
        has_selector?(element)
        puts "waiting for async element #{element} #{(Time.now - t1)*1000}\n\n\n"
      end

      private
        def initialize(page, group, user)
          super
        end
    end

    class DealOnPage  < Struct.new(:page_util, :deal)
      DEAL_TR_SELECTOR = '[deal-id="%d"]'
      DEAL_SHOW_DETAILS_SELECTOR = "#deals-panel.details"
      
      def click
        page_util.list.find(DEAL_TR_SELECTOR % deal.id).click
        page_util.wait_for_element(DEAL_SHOW_DETAILS_SELECTOR)
      end

      def visible?
        has_css? DEAL_SHOW_DETAILS_SELECTOR
      end
    end
  end
end