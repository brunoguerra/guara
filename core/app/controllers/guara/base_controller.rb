module Guara
  class BaseController < ActionController::Base
    protect_from_forgery
    check_authorization :unless => :devise_controller? #cancan
  
    include BaseHelper
    include SessionsHelper
    
    def current_ability
      @current_ability = Guara::Ability.new(current_user)
    end
  
    rescue_from CanCan::AccessDenied do |exception|
      Rails.logger.fatal "Access denied on #{exception.action} #{exception.subject.inspect}"
      Rails.logger.debug exception.backtrace.to_s
      redirect_to root_url, :flash => { :error => exception.message }
    end
  end
end
