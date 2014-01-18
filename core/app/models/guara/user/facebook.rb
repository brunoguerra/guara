module Guara
  class User
    class Facebook < ActiveRecord::Base
      attr_accessible :description, :identifier, :link, :name, :picture, :token
      belongs_to :user, :class_name => "Guara::User"

      def self.find_for_email_or_create(email, user_data, facebook_data)
        if user = User.where(:email => email).first
          user
        else
          begin
            password = Devise.friendly_token[0,20]

            user_data.merge!({:password => password, :password_confirmation => password, :complete => false})
            user = User.new(user_data)
            user_facebook = User::Facebook.create(facebook_data)
            user_facebook.user = user
            user_facebook.save!

            user.basic_abilities

            user
          rescue Exception => e
            Rails.logger.error(e.message)
            Rails.logger.error(user.errors.to_yaml)
            Rails.logger.error(e.backtrace.to_yaml)
            nil
          end
        end
      end
    end
  end
end
