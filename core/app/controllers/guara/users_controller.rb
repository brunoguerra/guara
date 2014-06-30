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
      if params[:user_registration]
        unless register_new_user
          render :json => { success: false, :errors => @user_new_reg.errors_as_json }
          return 
        end

        sign_in @user_new_reg.user
      else
        manual_login if current_user.nil? && params[:user]
      end

      unless current_user.nil?
        render :json => { success: true, :user => current_user.as_json(only: [:id, :name, :enabled]).merge({
            :remember_token_expires => (30.days.from_now),
            :remember_token => get_remember_user_token_cookie
          })
      }
      else
        render :json => { success: false, :user => nil }
      end
    end

    def register_new_user
      @user_new_reg = User.registration.registry(params[:user])
      !@user_new_reg.new_record?
    end

    def manual_login
      user = Guara::User.where(email: params[:user][:email]).first
      puts "User manual sign_in "+user.id.to_s if user
      sign_in(:user, user) if user && user.valid_password?(params[:user][:password])
    end

    def get_remember_user_token_cookie
      current_user.remember_me!


      cookies.signed["remember_user_token"] = {
        :value => current_user.class.serialize_into_cookie(current_user.reload),
        :expires => 3.months.from_now,
        :domain => request.host || "www.gotosunrise.com",
      }


      data = Rack::Session::Cookie::Base64::Marshal.new.encode(cookies.signed["remember_user_token"])
      data.gsub!(/\n/, '')
      digest = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.const_get('SHA1').new, Rails.application.config.secret_token, data)
      data + '--' + digest
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