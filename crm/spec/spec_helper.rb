puts "Loading guara_crm/spec/spec_helper..."

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../spec/dummy/config/environment", __FILE__)

require 'spork'
require 'faker'
require "guara_core"
require "database_cleaner"

include ActiveSupport
include Guara::BaseHelper


["app/**/", "lib/**/"].each do |glob|
  Dir.glob(glob).each do |dir| 
    Dependencies.autoload_paths << File.join(File.dirname(__FILE__), dir)
  end
end

#require 'rspec/rails' cleanup

require 'rspec/rails'
require 'rspec/autorun'

# factories
#require "factories" cleanup
require 'guara/test_support/configuration'

Guara::TestSupport.configure!

Spork.each_run do
  FactoryGirl.reload
end

puts "done!"