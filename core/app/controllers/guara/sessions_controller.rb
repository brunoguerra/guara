
module Guara
  class SessionsController < Devise::SessionsController
  
    skip_authorization_check :only => [:new, :create]

    def new
    end

=begin
    def create
      user = User.find_by_email(params[:session][:email])
      if user && user.authenticate(params[:session][:password])
        sign_in user
        redirect_back_or user
      else
        flash.now[:error] = t("sign.in.error")
        render 'new'
      end
    end

    def update
      self.create
    end

    def destroy
      sign_out
      redirect_to root_path
    end
=end
    
  end
end