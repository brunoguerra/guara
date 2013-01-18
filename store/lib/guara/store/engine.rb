
require 'guara_core'
require 'guara_crm'

require 'spree_core'
require 'spree_api'
require 'spree_dash'
require 'spree_promo'

module Guara
  module Store
    class Engine < ::Rails::Engine
      isolate_namespace Guara
      engine_name 'guara_store'
    
      #TODO Initialize rspec_paths
      #config.rspec_paths << self.root
      
      initializer "guara.activeadmin" do |app|
        ActiveAdmin.application.load_paths += Dir[File.dirname(__FILE__) + '/../admin']
      end
      
      
      initializer 'guara.menu.crm.items' do |app|
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
    
    end
  end
end
