puts "Loading guara_active_crm/spec/spec_helper..."

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../spec/dummy/config/environment", __FILE__)

require 'spork'
require 'faker'
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

require 'rspec/rails'
require 'rspec/autorun'

# factories
#require "factories" cleanup
require 'guara/test_support/configuration'

Guara::TestSupport.configure!

Spork.prefork do  
end

puts "done!"