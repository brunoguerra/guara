require 'devise'
require 'cancan'
require 'inherited_resources'
require 'will_paginate'
require 'bootstrap-sass'
require 'bootstrap-will_paginate'
require 'jquery-rails'
require 'rails-i18n'
require 'activeadmin'
require 'wicked_pdf'
#require 'ransack'

module Guara
  module Core
    class Engine < ::Rails::Engine
      isolate_namespace Guara
      engine_name 'guara'
            
      initializer "guara.activeadmin" do |app|
        ActiveAdmin.application.load_paths += Dir[File.dirname(__FILE__) + '/../admin']
      end
            
      initializer "guara.environment", :before => :load_config_initializers do |app|
        app.config.guara = Guara::Core::Environment.new
        require "#{File.dirname(__FILE__)}/../../../config/initializers/active_admin.rb"
        Dir["#{File.dirname(__FILE__)}/../../../config/guara/*.rb"].each { |f| require f;}
        puts Guara::Menus::MODULES.to_yaml
      end
      
      initializer "guara.load_preferences", :before => "guara.environment" do
        #TODO: make common models behaviours
      end
      
      #for devise and other dynamics routes
      config.after_initialize do
        Rails.application.routes_reloader.reload!
      end
      
      # sets the manifests / assets to be precompiled, even when initialize_on_precompile is false
      initializer "guara.assets.precompile", :group => :all do |app|
        app.config.assets.precompile += %w(guara/guara.css guara/guara.js)        
      end
      
      initializer "guara.devise" do
        DeviseController.layout "guara/base"
        Devise::SessionsController.layout "guara/base"
      end
      
      config.generators do |g|
        g.test_framework :rspec, :view_specs => false
      end
      
    end
  end
end
