
module Guara
  class SessionsController < Devise::SessionsController
    skip_authorization_check :only => [:new, :create]

    def new
    end
  end
end