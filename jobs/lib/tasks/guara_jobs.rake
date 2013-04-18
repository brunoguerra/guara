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

def prepare_partial_seeds(model, records)
  raws_record = []

  records.each do |rec|
    attr = rec.attributes
    attr_custom = '{'
    i = 0
    rec.attribute_names.each do |name|
      next if name == 'created_at' || name == 'updated_at'
      attr_custom += "," if i > 0
      if rec[name].class == String
        attr_custom += ":#{name}=> '#{rec[name]}'" 
      else
        if rec[name].nil?
          attr_custom += ":#{name}=> nil" 
        else
          attr_custom += ":#{name}=> #{rec[name]}" 
        end
      end
      i = 1
    end
    attr_custom += '}'
    raws_record << attr_custom
  end

  return "#{model}.create([
      #{raws_record.join(',
      ')}
  ])"
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

    #TEMPORARY - REMOVE
    task export_custom_process: :environment do |t, args|

      if ENV['process'].nil?
        custom_processes = Guara::Jobs::CustomProcess.all
      else
        puts "Exporting custom process #{ENV['process']}"
        custom_processes = [Guara::Jobs::CustomProcess.find(ENV['process'])]
      end

      
      models = []
      
      models << prepare_partial_seeds('Guara::Jobs::CustomProcess', custom_processes)

      custom_processes.each do |custom_process| 
        models << prepare_partial_seeds('Guara::Jobs::Step', custom_process.steps)

        custom_process.steps.each do |step|
          models << prepare_partial_seeds('Guara::Jobs::StepAttr', step.attrs)
        end
      end

      

      File.open("seeds-custom_process.rb", 'w') do |f|
        f.write models.join("

        ")  
      end
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