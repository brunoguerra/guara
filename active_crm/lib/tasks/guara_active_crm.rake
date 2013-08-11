# encoding: utf-8

require 'guara/rake'

Rake.application.remove_task 'guara:install'
Rake.application.remove_task 'guara:test:prepare'

namespace :guara do
    
    task install: :environment do
      execute_task "db:create"
      execute_task "guara:active_crm:db:migrate"
      execute_task "db:migrate"
      execute_task "guara:active_crm:db:seeds"
    end
    
    desc "Fill database with sample data"
    task populate_test: :environment do
      require File.dirname(__FILE__) + '/../../spec/factories.rb' if FileTest.exist? File.dirname(__FILE__) + '/../../spec/factories.rb'      
    end
    
    namespace :test do
      task prepare: :environment do
        ActiveRecord::Base.establish_connection('test')
        execute_task "guara:analysis:db:seeds"
        ActiveRecord::Base.establish_connection(ENV['RAILS_ENV'])  #Make sure you don't have side-effects!
      end
    end
    
    namespace :active_crm do
      namespace :db do
        task seeds: :environment do
          execute_task "guara:seeds"
          execute_task "guara:crm:db:load_seed"
          execute_task "guara:active_crm:db:load_seed"
        end
        
        task load_seed: :environment do
          Guara::ActiveCrm::Engine.load_seed
        end
      
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