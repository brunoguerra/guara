require 'rails3-jquery-autocomplete'
require 'active_extend'

module Guara
  module Crm    
    class Engine < ::Rails::Engine
      isolate_namespace Guara
      engine_name "guara_crm"
      
      initializer "guara.activeadmin" do |app|
        ActiveAdmin.application.load_paths += Dir[File.dirname(__FILE__) + '/../admin']
      end
      
      initializer 'guara.menu.crm.items' do |app|
        Guara::Menus::MODULES[:modules][:items] << { name: :customers,
                                                     resource: Guara::Customer,
                                                     path: "guara.customers_path()"
                                                    }
        
        Guara::Menus::MAINTENCE[:items] +=
          [
            { name: :business_activities, resource: Guara::BusinessActivity, path: "guara.maintence_guara_business_activities_path()" },
            { name: :business_segments, resource: Guara::BusinessSegment, path: "guara.maintence_guara_business_segments_path()" },
            { name: :business_departments, resource: Guara::BusinessDepartment, path: "guara.maintence_guara_business_departments_path()" },
            { name: :company_businesses, resource: Guara::CompanyBusiness, path: "guara.maintence_guara_company_businesses_path()" },
            { name: :task_types, resource: Guara::TaskType, path: "guara.maintence_guara_task_types_path()" },
          ]
        
      end
      
      config.generators do |g|
        g.test_framework :rspec, :view_specs => false
      end
      
    end
  end
end
