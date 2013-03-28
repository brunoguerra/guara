
require "paperclip"

module Guara  
  module Jobs
    class Engine < ::Rails::Engine
      isolate_namespace Guara
      engine_name 'guara_jobs'
    
      #TODO Initialize rspec_paths
      #config.rspec_paths << self.root
      
      initializer "guara.activeadmin" do |config|
        ActiveAdmin.application.load_paths += Dir[File.dirname(__FILE__) + '/../../../app/admin']
      end
      
      
      initializer 'guara.menu.crm.items' do |config|
        Guara::Menus::MODULES[:modules][:items] << { name: :jobs, resource: Guara::Jobs::Professional }
        
        Guara::Menus::MAINTENCE[:items] +=
          [
            { name: :jobs_business_actions, resource: Guara::Jobs::BusinessAction},
            { name: :jobs_roles, resource: Guara::Jobs::Role},
            { name: :jobs_level_educations, resource: Guara::Jobs::LevelEducation },
            { name: :jobs_consultants, resource: Guara::Jobs::Consultant },
            { name: :jobs_languages, resource: Guara::Jobs::Language },
            { name: :jobs_level_knowledges, resource: Guara::Jobs::LevelKnowledge },
            { name: :jobs_salary_requirements, resource: Guara::Jobs::SalaryRequirement },
          ]
        
      end
    
      config.generators do |g|                                                               
        g.test_framework :rspec
        g.integration_tool :rspec
      end
      
      initializer "guara.jobs.assets" do |config|
        puts config.assets.paths.size
        config.assets.paths << Rails.root.join("app", "assets", "stylesheet", "guara")
      end
    
    end
  end
end

Dir[File.expand_path("../process_instance/*.rb", __FILE__)].each {|f| require f; puts f; }
Dir[File.expand_path("../active_process/*.rb", __FILE__)].each {|f| require f; puts f; }
