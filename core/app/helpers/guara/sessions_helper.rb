# encoding: utf-8

module Guara
  module SessionsHelper    
    def signed_in?
      !current_user.nil?
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to new_user_session_path, notice: t("session.erros.restrict_redirected")
      end
    end

    def store_location
      session[:return_to] = request.fullpath
    end
  
    def preferences_customer_type=(type)
      session[:customer_type] = type
    end
  
    def preferences_customer_type?
      session[:customer_type] || :pj
    end
  end
end