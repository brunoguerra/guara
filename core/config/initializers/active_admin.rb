require "active_admin"

ActiveAdmin.setup do |config|

  config.site_title = "Guara"

  config.namespace :maintence do |maintence|
    maintence.site_title = "Guara"
  end
  config.authentication_method = :authenticate_user!
  config.current_user_method = :current_user  


  #config.before_filter :skip_authorization_check
  if !defined?(ApplicationController)
    ::ApplicationController = ::Guara::BaseController
  end
  
  ActiveAdmin::ResourceController.class_eval do
    authorize_resource

    def active_admin_collection
      super.accessible_by current_ability
    end
  end

  config.logout_link_path = :destroy_user_session_path
  config.batch_actions = true
  
  config.allow_comments = false
end

  #def authenticate_admin!
  # redirect_to new_user_session_path unless current_user.is_admin?
  #end

# Atention #####################################################################################
#mokey patch activeadmin running on Guara engines

module Guara
  module Admin
  end
  module Maintence
  end
end

module ActiveAdmin
  
  module Views
  
    module Pages
      class Base < Arbre::HTML::Document
      
        def build_header
          #insert_tag view_factory.header, active_admin_namespace, current_menu
          render "layouts/guara/active_admin_header"
        end 
      end
    end
  
    class Header < Component
    
      def build_global_navigation
        #insert_tag view_factory.global_navigation, @menu, :class => 'header-item' 
        #render "layouts/active_admin_header"
      end

    end
  
    class Footer < Component

      def build
        super :id => "footer"
        #powered_by_message
        render "layouts/guara/active_admin_footer"
      end

      private

      def powered_by_message
        para "Guara".html_safe
      end

    end
  end
  
  class Resource
    module Controllers

      # Returns a properly formatted controller name for this
      # config within its namespace
      def controller_name
        ["Guara", namespace.module_name, resource_name.plural.camelize + "Controller"].compact.join('::')
      end
    end
  end
  
  class Namespace
    
    def register_resource_controller(config)
      eval "class ::#{config.controller_name} < ActiveAdmin::ResourceController; end"
      #if config.resource_name.index("Guara") != nil
        #MyEngine::Resource => ::MyEngineResource #cancan will try to find MyEngineResource instead Guara::Resource on url my_guara_resource
        begin
          eval "class ::#{config.resource_name.gsub(/::/, '')} < #{config.resource_name}; end"
        rescue
        end
      #end
      config.controller.active_admin_config = config
    end
    
  end
  
#  class Engine < Rails::Engine
#    if Rails.version > "3.1"
#      initializer "ActiveAdmin precompile hooked" do |app|
#        app.config.assets.precompile += %w(guara/active_admin.js guara/active_admin.css active_admin/print.css)
#      end
#    end
#  end

# Adds links to View, Edit and Delete

  module Views
    class IndexAsTable < ActiveAdmin::Component
        def default_actions(options = {})
          options = {
            :name => ""
          }.merge(options)
          column options[:name] do |resource|
            links = ''.html_safe
            if controller.action_methods.include?('show')
              if can? :read, resource
                links << link_to(I18n.t('active_admin.view'), resource_path(resource), :class => "member_link view_link")
              end
            end
            if controller.action_methods.include?('edit')
              if can? :update, resource
                links << link_to(I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link")
              end
            end
            if controller.action_methods.include?('destroy')
              if can? :destroy, resource
                links << link_to(I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :data => {:confirm => I18n.t('active_admin.delete_confirmation')}, :class => "member_link delete_link")
              end
            end
            links
          end
        end
    end
    
    class AttributesTable < ActiveAdmin::Component
        def header_content_for(attr)
        if @record.class.respond_to?(:human_attribute_name)
          I18n.t('activerecord.attributes.%s.%s' % [resource_class.model_name.underscore, attr.to_s], :default => @record.class.human_attribute_name(attr, :default => attr.to_s.titleize))
        else
          attr.to_s.titleize
        end
      end
    end
    module Pages
  
      class Index < Base
        def default_index_config
          @default_index_config ||= ::ActiveAdmin::PagePresenter.new(:as => :table) do |display|
            selectable_column
            #id_column
            resource_class.content_columns.each do |col|
              if (col.name != 'id') && (col.name != 'created_at') && (col.name != 'updated_at')
                column I18n.t('activerecord.attributes.%s.%s' % [resource_class.model_name.underscore, col.name], :default => resource_class.human_attribute_name(col.name, :default => col.name.titleize)), col.name.to_sym
              end
            end
            default_actions
          end
        end
      end
    end
  end
end

class ::Ability < Guara::Ability; end

Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end

ActionView::Base.send :include, Guara::MenuHelper
ActionView::Base.send :include, Guara::UsersHelper
