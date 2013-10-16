require 'devise/strategies/database_authenticatable'
require 'fb_graph'
require 'warden'

module Devise
  module Strategies
    class FbMobileDatabaseAuthenticatable < Authenticatable
  def valid?
    # if we have headers with the facebook access key
    !!request.headers["fb_access_token"]
  end

  def authenticate!
    token = request.headers["fb_access_token"]
    fbuser = FbGraph::User.me(token)
    fbuser = fbuser.fetch

    user = User.find_for_facebook_mobile_client(fbuser.email)

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
                       Devise::Strategies::FbMobileDatabaseAuthenticatable)