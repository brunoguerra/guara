
require 'factory_girl'

require 'guara/test_support/custom_matchers'
require 'guara/test_support/utilities'
require 'capybara-webkit'

module Guara
  module TestSupport
   

   @@excepted_tables =  %w[SystemAbility SystemModule SystemTaskStatus SystemTaskResolution State City BusinessSegment BusinessActivity].collect { |e| "guara_"+pluralize_without_count(2, e.underscore) }
    
    def self.excepted_tables_add(tables)
      @@excepted_tables += tables
    end

    def self.config_transactional(config)

      config.before :each do
        if Capybara.current_driver == :rack_test
          DatabaseCleaner.strategy = :transaction, {:except => @@excepted_tables }
        else
          DatabaseCleaner.strategy = :truncation, { :except => @@excepted_tables }
        end
        DatabaseCleaner.start
      end

      config.after :each do
        DatabaseCleaner.clean
      end
    end
  
    def self.configure!

      #capybara
      Capybara.javascript_driver = :webkit

      RSpec.configure do |config|

        I18n.locale = :"pt-BR"
        #devise
        config.include Devise::TestHelpers, :type => :controller
        config.include FactoryGirl::Syntax::Methods
        config.include Guara::Core::Engine.routes.url_helpers
        config.include Guara::BaseHelper

        config.include Guara::TestSupport::Utilities

        #capybara
        config.include Warden::Test::Helpers
        #Warden.test_mode!

        self.config_transactional config
        #config.infer_base_class_for_anonymous_controllers = false
        config.order = "random"

        config.before(:each) do
            full_example_description = "Starting #{self.class.description} #{@method_name}"
            Rails.logger.info("\n\n#{full_example_description}\n#{'-' * (full_example_description.length)}")      
        end

        config.after(:each) do
          clear_test_dummy 
        end

        Spork.each_run do
          FactoryGirl.factories.clear
          FactoryGirl.reload
        end
      end 

    end
  end
end

