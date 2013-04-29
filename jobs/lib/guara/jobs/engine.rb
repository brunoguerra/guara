require File.expand_path("../../active_process/process_hooker", __FILE__)
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
        
        routes = Guara::Core::Engine.routes.url_helpers
        
        Guara::Menus::MAINTENCE[:items] +=
          [
            { 
              name: :jobs_business_actions, resource: Guara::Jobs::BusinessAction, 
              path: routes.respond_to?('maintence_guara_business_actions_path') ?
                "guara.maintence_guara_business_actions_path()" : 
                "guara.maintence_guara_jobs_business_actions_path()"
            },
            { 
              name: :jobs_roles, resource: Guara::Jobs::Role, 
              path: routes.respond_to?('guara.maintence_guara_roles_path') ?
                "guara.maintence_guara_roles_path()" : 
                "guara.maintence_guara_jobs_roles_path()"
            },
            { 
              name: :jobs_level_educations, resource: Guara::Jobs::LevelEducation, 
              path: routes.respond_to?('guara.maintence_guara_level_educations_path') ?
                "guara.maintence_guara_level_educations_path()" : 
                "guara.maintence_guara_jobs_level_educations_path()"
            },
            { 
              name: :jobs_consultants, resource: Guara::Jobs::Consultant, 
              path: routes.respond_to?('guara.maintence_guara_consultants_path') ?
                "guara.maintence_guara_consultants_path()" : 
                "guara.maintence_guara_jobs_consultants_path()" 
            },
            { 
              name: :jobs_languages, resource: Guara::Jobs::Language, 
              path: routes.respond_to?('guara.maintence_guara_languages_path') ?
                "guara.maintence_guara_languages_path()" : 
                "guara.maintence_guara_jobs_languages_path()" 
            },
            { 
              name: :jobs_level_knowledges, resource: Guara::Jobs::LevelKnowledge, 
              path: routes.respond_to?('guara.maintence_guara_level_knowledges_path') ?
                "guara.maintence_guara_level_knowledges_path()" : 
                "guara.maintence_guara_jobs_level_knowledges_path()" 
            }
          ]
        
      end
    
      config.generators do |g|                                                               
        g.test_framework :rspec
        g.integration_tool :rspec
      end
      
      initializer "guara.jobs.assets" do |config|
        config.assets.paths << Rails.root.join("app", "assets", "stylesheet", "guara")
      end
    
    end
  end
end

Dir[File.expand_path("../process_instance/*.rb", __FILE__)].each {|f| require f; puts f; }
Dir[File.expand_path("../active_process/*.rb", __FILE__)].each {|f| require f; puts f; }
