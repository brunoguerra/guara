require 'devise/strategies/database_authenticatable'

begin
  require 'fb_graph'
  require 'warden'

  module Guara
    module Core

      class DeviseFbApiStrategy < Devise::Strategies::Authenticatable
        def valid?
          # if we have headers with the facebook access key
          !!request.headers["fb_access_token"]
        end

        def authenticate!
          token = request.headers["fb_access_token"]
          Rails.logger.info(":::FB_TOKEN: #{token}")
          fbuser = FbGraph::User.me(token)
          fbuser = fbuser.fetch

          facebook_data = {
            :identifier  => fbuser.identifier,
            :picture     => fbuser.picture,
            :link        => fbuser.link,
            :token       => token
          }
          user = User::Facebook.find_for_email_or_create(fbuser.email, {name: fbuser.name, email: fbuser.email}, facebook_data)

          # this either creates a new user for the valid FB account, or attaches
          # this session to an existing user that has the same email as the FB account

          if !!user && validate(user) { true }
            user.after_database_authentication
            success!(user)
          elsif !halted? || !user
            fail(:invalid)
          end
        end
      end
    end
  end

  Warden::Strategies.add(:fb_database_authenticatable,
                         Guara::Core::DeviseFbApiStrategy)

rescue Exception => e
  Rails.logger.error('error on loading DeviseFbApiStrategy')
  Rails.logger.error(e.message)
  Rails.logger.error(e.backtrace.to_yaml)
end