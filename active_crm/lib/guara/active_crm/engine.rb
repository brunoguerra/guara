require 'active_extend'

module Guara
  module ActiveCrm
    class Engine < ::Rails::Engine
      isolate_namespace Guara
      engine_name 'guara_active_crm'

      require 'jquery-ui-rails'
      
      #TODO Initialize rspec_paths
      #config.rspec_paths << self.root

      config.to_prepare do
        #loads application's model / class decorators
        Dir[File.expand_path('../../../../app/**/*_decorator*.rb', __FILE__)].each do |c|
          Rails.application.config.cache_classes ? require(c) : load(c)
        end
      end
      
      initializer "guara.activeadmin" do |config|
        ActiveAdmin.application.load_paths += Dir[File.dirname(__FILE__) + '/../../../app/admin']
      end
      

      initializer 'guara.menu.guara.active_crm.items' do |config|
        Guara::Menus::MODULES[:modules][:items] << { 

          name: :active_crm,
          items: [
              { name: "active_crm.scheduled", resource: Guara::ActiveCrm::Scheduled, path: "guara.scheduleds_path()" },
              { name: "active_crm.scheduled_deals", resource: Guara::ActiveCrm::Scheduled::Deals, path: "guara.scheduled_deals_path()" },
              { name: "active_crm.scheduled_contacts_reports", resource: Guara::ActiveCrm::Scheduled, path: "guara.scheduled_contacts_reports_path()" }
            ]
        }
        
        Guara::Menus::MAINTENCE[:items] += [ { name: "active_crm.scheduled_classifieds", resource: Guara::ActiveCrm::Scheduled::Classified, path: "guara.maintence_guara_active_crm_scheduled_classifieds_path()" } ]

      end
    
      config.generators do |g|
        g.test_framework :rspec
        g.integration_tool :rspec
      end
      
      initializer "guara.guara.assets" do |config|
        config.assets.paths << Rails.root.join("app", "assets", "stylesheet", "guara")
      end
    
    end
  end
end

Dir[File.expand_path("../dependencies/*.rb", __FILE__)].each {|f| require f; }
