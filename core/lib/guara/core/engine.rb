require "devise"
require "cancan"
require "inherited_resources"
require "will_paginate"

module Guara
  module Core
    class Engine < ::Rails::Engine
      isolate_namespace Guara
      engine_name 'guara'
      
      #for devise and other dynamics routes
      config.after_initialize do
        Rails.application.routes_reloader.reload!
      end
      
      #config.autoload_paths << File.expand_path("../../config/guara", __FILE__)
      
      Dir["#{File.dirname(__FILE__)}/../../../config/guara/*.rb"].each { |f| require f }
    
      initializer "guara.environment", :before => :load_config_initializers do |app|
        app.config.guara = Guara::Core::Environment.new
      end

      initializer "guara.load_preferences", :before => "guara.environment" do
        #TODO: make common models behaviours
        #::ActionController::Base.send :include, Guara::SessionHelper
      end
        
    end
  end
end
