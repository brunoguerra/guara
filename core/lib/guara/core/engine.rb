require 'devise'
require 'cancan'
require 'inherited_resources'
require 'will_paginate'
require 'bootstrap-sass'
require 'bootstrap-will_paginate'
require 'jquery-rails'
require 'rails-i18n'
require 'activeadmin'

module Guara
  module Core
    class Engine < ::Rails::Engine
      isolate_namespace Guara
      engine_name 'guara'
      
      #config.autoload_paths << File.expand_path("../../config/guara", __FILE__)
      
      Dir["#{File.dirname(__FILE__)}/../../../config/guara/*.rb"].each { |f| require f }
      
      initializer "guara.environment", :before => :load_config_initializers do |app|
        app.config.guara = Guara::Core::Environment.new
      end
      
      initializer "guara.load_preferences", :before => "guara.environment" do
        #TODO: make common models behaviours
      end
      
      initializer "guara.activeadmin" do |app|
        ActiveAdmin.application.load_paths += Dir[File.dirname(__FILE__) + '/../admin']
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
        Devise::SessionsController.layout "guara/base"
        Devise::RegistrationsController.layout "guara/base"
        Devise::ConfirmationsController.layout "guara/base"
        Devise::UnlocksController.layout "guara/base"            
        Devise::PasswordsController.layout "guara/base"
      end
      
    end
  end
end
