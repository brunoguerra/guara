module Guara
  class UsersController < BaseController
    load_and_authorize_resource class: Guara::User
    before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
    before_filter :correct_user,   only: [:edit, :update]
    before_filter :admin_user,     only: :destroy

    helper CrudHelper
    
    def index
      @users = @users.paginate(page: params[:page])
    end
  
    def show
      @microposts = @user.microposts.paginate(page: params[:page])
    end

    def new
      @user = User.new
    end
  
    def create
      @user = User.new(params[:user])
      if @user.save
        redirect_to @user
      else
        render 'new'
      end
    end
  
    def update
      #@user = User.find(params[:id])
      if params[:user][:password].nil? || params[:user][:password].empty?
        params[:user].delete :password
        params[:user].delete :password_confirmation
      end
      
      if @user.update_attributes(params[:user])
        redirect_to @user
      else
        render 'edit'
      end
    end
  
    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed."
      redirect_to users_path
    end
    
    
    private

      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user.admin? || current_user.email == @user.email
      end

      def admin_user
        redirect_to(root_path) unless current_user.admin?
      end
  
  end
end