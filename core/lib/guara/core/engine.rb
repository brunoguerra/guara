
require "devise"
require "cancan"
require "inherited_resources"

module Guara
  module Core
    class Engine < ::Rails::Engine
      isolate_namespace Guara
      engine_name 'guara'
    
      #for devise and other dynamics routes
      config.after_initialize do
        Rails.application.routes_reloader.reload!
      end
    
      initializer "guara.environment", :before => :load_config_initializers do |app|
        app.config.guara = Guara::Core::Environment.new
      end

      initializer "guara.load_preferences", :before => "guara.environment" do
        #TODO: make common models behaviours 
        #::ActiveRecord::Base.send :include, 
      end
        
    end
  end
end
