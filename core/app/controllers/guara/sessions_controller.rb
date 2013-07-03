
module Guara
  class SessionsController < Guara::BaseController

    def change
    	authorize! :read, :customer
    	set_current_company_branch(params['company_branch_id'])
    	redirect_to root_path
    end

  end
end