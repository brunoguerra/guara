# encoding: utf-8

require 'guara/rake'

Rake.application.remove_task 'guara:install'
Rake.application.remove_task 'guara:test:prepare'

namespace :guara do
    
    task install: :environment do
      execute_task "db:create"
      execute_task "guara:active_crm:db:migrate"
      execute_task "guara:active_crm:seeds"
    end
    
    desc "Fill database with sample data"
    task populate_test: :environment do
      require File.dirname(__FILE__) + '/../../spec/factories.rb' if FileTest.exist? File.dirname(__FILE__) + '/../../spec/factories.rb'      
    end
    
    namespace :test do
      task :prepare do
        Rails.env = ENV['RAILS_ENV'] = 'test'
        execute_task "environment"
        ActiveRecord::Base.establish_connection
        execute_task "guara:install"
      end
    end

    namespace :active_crm do

      task seeds: :environment do
        execute_task "guara:crm:seeds"
        Guara::ActiveCrm::Engine.load_seed
      end

      namespace :db do
        task migrate: :environment do
          execute_task "db:create"
          execute_task "guara:install:migrations"
          execute_task "guara_crm:install:migrations"
          execute_task "guara_active_crm:install:migrations"
          execute_task "db:migrate"
        end
      end
    end
end