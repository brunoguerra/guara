require 'rspec'

module GuaraStore
  class Engine < ::Rails::Engine
    isolate_namespace GuaraStore
    
    #TODO Initialize rspec_paths
    #config.rspec_paths << self.root
    
    config.generators do |g|                                                               
      g.test_framework :rspec
      g.integration_tool :rspec
    end
    
  end
end
