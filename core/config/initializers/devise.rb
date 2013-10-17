Devise.setup do |config|
  #mobile integration with ajax
  config.http_authenticatable_on_xhr = false
  config.navigational_formats = ["*/*", :html, :json]

  #not isolated engine
  config.router_name = :guara
  
  config.mailer_sender = "ti@woese.com"

  require 'devise/orm/active_record'
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.http_authenticatable = true
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.timeout_in = 4.hours
  config.reset_password_within = 6.hours
  config.sign_out_via = Rails.env.test? ? :get : :delete

  begin
    require 'fb_graph'
    config.warden do |manager|
      manager.default_strategies(:scope => :user).unshift :fb_database_authenticatable
    end
  rescue
  end
end

ActionView::Base.send :include, Guara::BaseHelper

Devise::SessionsController.layout "guara/base"