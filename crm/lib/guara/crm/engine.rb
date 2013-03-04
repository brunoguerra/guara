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
        Guara::Menus::MODULES[:modules][:items] << :customers
        
        Guara::Menus::MAINTENCE[:items] +=
          [
            :business_activities,
            :business_segments,
            :business_departments,
            :company_businesses,
            :task_types,
          ]
        
      end
      
    end
  end
end
