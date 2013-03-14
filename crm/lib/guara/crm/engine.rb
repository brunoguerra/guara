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
                                                     resource: Guara::Customer
                                                    }
        
        Guara::Menus::MAINTENCE[:items] +=
          [
            { name: :business_activities, resource: Guara::BusinessActivity },
            { name: :business_segments, resource: Guara::BusinessSegment },
            { name: :business_departments, resource: Guara::BusinessDepartment },
            { name: :company_businesses, resource: Guara::CompanyBusiness },
            { name: :task_types, resource: Guara::TaskType },
          ]
        
      end
      
    end
  end
end
