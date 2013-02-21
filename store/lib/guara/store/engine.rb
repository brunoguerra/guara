require 'spree_core'
require 'spree_api'
require 'spree_dash'
require 'spree_promo'
require 'meta_search'
require 'rails3-jquery-autocomplete'

module Guara  
  module Store
    class Engine < ::Rails::Engine
      isolate_namespace Guara
      engine_name 'guara_store'
    
      #TODO Initialize rspec_paths
      #config.rspec_paths << self.root
      
      initializer "guara.activeadmin" do |config|
        ActiveAdmin.application.load_paths += Dir[File.dirname(__FILE__) + '/../../../app/admin']
      end
      
      
      initializer 'guara.menu.crm.items' do |config|
        Guara::Menus::MODULES[:modules][:items] << :stock
        
        Guara::Menus::MAINTENCE[:items] +=
          [
            :store_categories,
          ]
        
      end
    
      config.generators do |g|                                                               
        g.test_framework :rspec
        g.integration_tool :rspec
      end
      
      initializer "guara.store.assets" do |config|
        puts config.assets.paths.size
        config.assets.paths << Rails.root.join("app", "assets", "stylesheet", "guara")
      end
    
    end
  end
end
