module Guara
  class UsersController < BaseController
    load_and_authorize_resource class: Guara::User, :except => [:sign_out, :init]
    skip_authorization_check :only => [:sign_out, :init]
    before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
    before_filter :correct_user,   only: [:edit, :update]
    before_filter :admin_user,     only: :destroy

    before_filter :process_chains,  only: [:index, :new, :edit, :create, :update, :destroy]
    before_filter :partials_loader, only: [:index, :new, :edit]

    helper CrudHelper

    @@processors = []
    @@partials = {
     :new  => [],
     :edit  => [],
     :form => [],
     :index => []
    }
    
    def index
      @users = @users.unscoped.where(enabled: false).order("name") if params[:disabled]=='true'
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
      if save
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
      
      @user.attributes = params[:user]

      if save
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

    def sign_out
      reset_session
      redirect_to new_user_session_path
    end

    def init
      unless current_user.nil?
        render :json => { success: true, :user => current_user.as_json(only: [:id, :name, :enabled]) }
      else
        render :json => { success: false, :user => nil }
      end
    end

    # extensible
    def self.add_form_partials(action, partial)
      @@partials[action] << partial
    end

    def self.add_form_processor(processor)
      @@processors ||= []
      @@processors << processor
    end

    # Private Methods
    private

      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user.admin? || current_user.email == @user.email
      end

      def admin_user
        redirect_to(root_path) unless current_user.admin?
      end

      def process_chains
        UsersController.processors_instace.each do |processor|
          action = params[:action]
          params_to_process = params
          puts params_to_process.to_yaml
          params = processor.process(action, params_to_process, @user)
        end
      end

      def self.processors_instace
        @@processors_instance ||= (@@processors || []).collect do |processor_str|
          processor_str.constantize.new
        end
      end

      def save
        returns = false
        Guara::User.transaction do
          returns = filter_save(:before_save) && @user.save && filter_save(:after_save)

          raise ActiveRecord::Rollback.new unless returns
        end
        returns
      end

      def filter_save(filter)
        result = true
        UsersController.processors_instace.each do |processor|
          result &&= processor.filter(filter, params, @user) if processor.respond_to? :filter
        end

        result
      end

      def partials_loader
        puts params[:action].inspect
        puts @@partials.to_yaml
        case params[:action]
        when 'new', 'edit'
          @partials_form = [] + (@@partials[:form] || [])
        end
      end
  end
end