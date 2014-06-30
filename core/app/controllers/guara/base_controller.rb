module Guara
  class BaseController < ActionController::Base
    protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }
    check_authorization :unless => :devise_controller? #cancan
    around_filter :set_time_zone
    
    include BaseHelper
    include SessionsHelper
    helper CrudHelper


    def set_time_zone
      old_time_zone = Time.zone
      Time.zone = current_user.time_zone if user_signed_in?
      yield
    ensure
      Time.zone = old_time_zone
    end


    def paginate(search, page=nil, per_page=10)
      page = page || params[:page] || 1
      
      if class_exists?("Ransack")
        return search.result().paginate(page: page, :per_page => per_page)
      else
        return search.paginate(page: page, :per_page => per_page)
      end
    end
    
    def current_ability
      @current_ability = Guara::Ability.new(current_user)
    end

    #bug: assets - after login devise devise-2.2.4 redirects to /assets?action=home&controoler=guara&...
    #def after_sign_in_path_for(resource)
    #  guara.home_path()
    #end
  
    rescue_from CanCan::AccessDenied do |exception|
      Rails.logger.fatal "Access denied on #{exception.action} #{exception.subject.inspect}"
      Rails.logger.debug exception.backtrace.to_s
      redirect_to guara.new_user_session_path(), :flash => { :error => exception.message }
    end
  end
end
