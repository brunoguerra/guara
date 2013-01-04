require 'guara_core'

module Guara
  module Crm
    class Engine < ::Rails::Engine
      isolate_namespace Guara
      engine_name "guara_crm"
      
      initializer 'guara.menu.crm.items' do |app|
        Guara::Menus::MODULES[:modules][:items] << :customers
      end
      
    end
  end
end
