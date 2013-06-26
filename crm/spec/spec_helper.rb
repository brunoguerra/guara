puts "Loading guara_crm/spec/spec_helper..."

#require 'rubygems' cleanup
#require "rails" cleanup

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../spec/dummy/config/environment", __FILE__)

#require 'action_controller' #fixing inherited resources not load on engine mode cleanup
require 'spork'
#require "capybara/rspec" cleanup
require "guara_core"
require "database_cleaner"
#require File.dirname(__FILE__) + '/../app/helpers/guara/base_helper.rb'

include ActiveSupport
include Guara::BaseHelper


["app/**/", "lib/**/"].each do |glob|
  Dir.glob(glob).each do |dir| 
    Dependencies.autoload_paths << File.join(File.dirname(__FILE__), dir)
  end
end

#require 'rspec/rails' cleanup

require 'rspec/autorun'
require 'factory_girl'
require 'ffaker'

require

#capybara
#Capybara.javascript_driver = :webkit


def config_transactional(config)
  
  except_tables = %w[SystemAbility SystemModule SystemTaskStatus SystemTaskResolution State City BusinessSegment BusinessActivity].collect { |e| pluralize_without_count(2, e.underscore) }
  
  config.before :each do
    if Capybara.current_driver == :rack_test
      DatabaseCleaner.strategy = :transaction, {:except => except_tables}
    else
      DatabaseCleaner.strategy = :truncation, {:except => except_tables}
    end
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end

RSpec.configure do |config|
  
  I18n.locale = :"pt-BR"
  
  config.include Devise::TestHelpers, :type => :controller
  config.include FactoryGirl::Syntax::Methods
  config_transactional config
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.before(:each) do
      full_example_description = "Starting #{self.class.description} #{@method_name}"
      Rails.logger.info("\n\n#{full_example_description}\n#{'-' * (full_example_description.length)}")      
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  clear_test_dummy
  
  FactoryGirl.reload
end

puts "done!"