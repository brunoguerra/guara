module Guara
  class BaseController < ActionController::Base
    protect_from_forgery
    check_authorization :unless => :devise_controller? #cancan
    
    include BaseHelper
    include SessionsHelper
    helper CrudHelper

    def paginate(search, page=1, per_page=10)
      if class_exists?("Ransack")
            return search.result().paginate(page: page, :per_page => per_page)
        else
            return search.paginate(page: page, :per_page => per_page)
        end
    end
    
    def current_ability
      @current_ability = Guara::Ability.new(current_user)
    end
  
    rescue_from CanCan::AccessDenied do |exception|
      Rails.logger.fatal "Access denied on #{exception.action} #{exception.subject.inspect}"
      Rails.logger.debug exception.backtrace.to_s
      redirect_to new_user_session_path(), :flash => { :error => exception.message }
    end
  end
end
