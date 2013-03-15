#rake db:migrate
#rake db:seed
#rake spree_sample:load

# encoding: utf-8

def execute_task task
  puts "starting #{task}..."
  Rake::Task["railties:install:migrations"].reenable
  Rake::Task[task].reenable
  r = Rake::Task[task].invoke
  puts "#{task} done! #{r}"
end

namespace :guara do
    
    task install: :environment do
      execute_task "db:create"
      execute_task "guara:db:migrate"
      execute_task "guara:seeds"
    end
    
    task seeds: :environment do
      Guara::Core::Engine.load_seed
      Guara::Crm::Engine.load_seed
      Guara::Jobs::Engine.load_seed
    end
    
    desc "Fill database with sample data"
    task populate_test: :environment do 
      FileTest.exist? File.dirname(__FILE__) + '/../../spec/factories.rb'
      require File.dirname(__FILE__) + '/../../spec/factories.rb'
      5.times { Factory(:customer_pj) }
    end
    
    namespace :db do
      
      task migrate: :environment do
        execute_task "db:create"
        execute_task "guara:install:migrations"
        execute_task "guara_crm:install:migrations"
        execute_task "guara_jobs:install:migrations"
        execute_task "db:migrate"
      end
    end
    
end