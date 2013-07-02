puts "Loading guara_core/spec/spec_helper..."
#require 'rubygems' cleanup
#require "rails" cleanup

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../spec/dummy/config/environment", __FILE__)

#require 'action_controller' #fixing inherited resources not load on engine mode cleanup
require 'spork'
require 'faker'
require "guara_core"
require "database_cleaner"
require File.dirname(__FILE__) + '/../app/helpers/guara/base_helper.rb'

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