
module Guara
  class StaticPagesController < BaseController
    before_filter :signed_in_user, only: [:home]
    before_filter :set_view_controller

    #before_filter :authenticate_user!, only: [:home, :edit, :update, :destroy]  #devise
    skip_authorization_check :only => [:home]
        
    def home
      if user_signed_in?
        @micropost  = current_user.microposts.build
        @feed_items = current_user.feed.paginate(page: params[:page])
      end
      @column_one = Rails.application.config.guara.partials.home[:collumn_one] || []
      @column_two = Rails.application.config.guara.partials.home[:collumn_two] || []
    end
    
    def help
    end
    
    def about
    end
    
    def contact
    end

    private
      def set_view_controller
        @controller = self
      end
  end
end