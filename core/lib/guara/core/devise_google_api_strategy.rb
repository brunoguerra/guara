require 'devise/strategies/database_authenticatable'

begin
  require 'google/api_client'
  require 'google/api_client/client_secrets'
  require 'google-id-token'
  require 'warden'

  module Guara
    module Core

      class DeviseGoogleApiStrategy < Devise::Strategies::Authenticatable

        cattr_accessor :credentials, :client

        # Build the global client
        @@credentials = Google::APIClient::ClientSecrets.load
        @@client = Google::APIClient.new application_name: "EasyBeer", application_version: "1.0"
        @@client.authorization = @@credentials.to_authorization


        def valid?
          #raise request.headers.inspect
          # if we have headers with the facebook access key
          !!request.headers["google_access_token"]
        end

        def authenticate!
          token = request.headers["google_access_token"]
          Rails.logger.info(":::GOOGLE_TOKEN: #{token}")

          (id_token, access_token) = token.split(" ")
          google_data = verify(id_token, access_token)

          unless google_data ||
                 google_data[:token_status]['id_token_status']['valid'] ||
                 google_data[:token_status]['access_token_status']['valid']
            return false
          end


          puts "="*200
          puts google_data.to_yaml
          puts "="*200

          email = google_data[:userinfo]["email"]

          if email.nil? || email.empty?

            slink = google_data[:userinfo][:link].split("=")

            if (slink.length>1)
              slink = slink[slink.length-1]
            else
              slink = slink[0].split("/")
              slink = slink[slink.length-1]
            end

            email = slink + '@u.google.com'
          end

          user = User::GoogleAuth.find_for_email_or_create(email, {name: google_data[:userinfo]['name'][0..99], email: email}, google_data)

          # this either creates a new user for the valid FB account, or attaches
          # this session to an existing user that has the same email as the FB account

          if !!user && validate(user) { true }
            user.after_database_authentication
            success!(user)
          elsif !halted? || !user
            fail(:invalid)
          end
        end



        def verify(id_token, access_token)

          result = {}
          token_status = {}

          id_status = {}
          if id_token
            # Check that the ID Token is valid.
            validator = GoogleIDToken::Validator.new
            client_id = @@credentials.client_id
            jwt = validator.check(id_token, client_id, client_id)
            if jwt
              id_status['valid'] = true
              id_status['gplus_id'] = jwt['sub']
              id_status['message'] = 'Valid ID Token.'
            else
              id_status['valid'] = false
              id_status['gplus_id'] = nil
              id_status['message'] = 'Invalid ID Token.'
            end
            token_status['id_token_status'] = id_status
          end


          #tokeninfo

          access_status = {}
          if access_token
            # Check that the Access Token is valid.
            oauth2 = @@client.discovered_api('oauth2','v2')
            @@client.authorization.access_token = access_token
            tokeninfo = JSON.parse(@@client.execute(oauth2.tokeninfo,
                :access_token => access_token).response.body)

            result[:tokeninfo] = tokeninfo

            if tokeninfo['error']
              # This is not a valid token.
              access_status['valid'] = false
              access_status['gplus_id'] = nil
              access_status['message'] = 'Invalid Access Token.'
            elsif tokeninfo['issued_to'] != @@credentials.client_id
              # This is not meant for this app. It is VERY important to check
              # the client ID in order to prevent man-in-the-middle attacks.
              access_status['valid'] = false
              access_status['gplus_id'] = nil
              access_status['message'] = 'Access Token not meant for this app.'
            else
              access_status['valid'] = true
              access_status['gplus_id'] = tokeninfo['user_id']
              access_status['message'] = 'Valid Access Token.'


              userinfo = JSON.parse(@@client.execute(oauth2.userinfo.get,
                :access_token => access_token).response.body)

              result[:userinfo] = userinfo
            end
            token_status['access_token_status'] = access_status
          end

          result[:token_status] = token_status
          result[:token] = id_token

          result
        end


  
      end
    end
  end

  Warden::Strategies.add(:google_database_authenticatable,
                         Guara::Core::DeviseGoogleApiStrategy)

rescue Exception => e
  Rails.logger.error('error on loading DeviseGoogleApiStrategy')
  Rails.logger.error(e.message)
  Rails.logger.error(e.backtrace.to_yaml)
end