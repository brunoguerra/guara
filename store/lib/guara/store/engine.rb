
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
    
      config.generators do |g|                                                               
        g.test_framework :rspec
        g.integration_tool :rspec
      end
    
    end
  end
end
