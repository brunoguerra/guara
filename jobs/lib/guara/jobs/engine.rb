
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
        Guara::Menus::MODULES[:modules][:items] << :jobs
        
        Guara::Menus::MAINTENCE[:items] +=
          [
            :jobs_business_actions,
            :jobs_roles,
            :jobs_level_educations,
            :jobs_consultants,
            :jobs_languages
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

require "guara/jobs/process_instance/vacancy_process_hook" 
puts File.expand_path("../active_process/*.rb", __FILE__)
Dir[File.expand_path("../active_process/*.rb", __FILE__)].each {|f| require f; puts f; }
