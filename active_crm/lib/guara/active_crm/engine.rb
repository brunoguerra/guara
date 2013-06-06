module Guara
  module ActiveCrm
    class Engine < ::Rails::Engine
      isolate_namespace Guara
      engine_name 'guara_active_crm'
      
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
      
      initializer 'guara.active_crm.items' do |config|
        Guara::Menus::MODULES[:modules][:items] << { 
          name: "guara.active_crm", resource: Guara::ActiveCrm::ActiveCrm, path: "guara.active_crm_index_path()",
          items: [
              { name: :guara_check_analysis, resource: Guara::ActiveCrm::CheckRemote, path: "guara.check_analyses_path()" },
            ]
        }
        #Guara::Menus::MAINTENCE[:items] += [ { name: :guara_, resource: Guara::ActiveCrm:: path: "guara.maintence_guara_active_crm_xxx_path()" } ]
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
