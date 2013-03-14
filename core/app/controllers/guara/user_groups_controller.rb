
module Guara
  class UserGroupsController < BaseController
    load_and_authorize_resource class: Guara::UserGroup
    helper CrudHelper
    
    def index
      @user_groups = @user_groups.paginate(page: params[:page], per_page: 10)
    end
    
    def create
      if @user_group.save
        redirect_to @user_group
      else
        render "new"
      end
    end
    
    def update
      if @user_group.save
        redirect_to @user_group
      else
        render "edit"
      end
    end
    
  end
end