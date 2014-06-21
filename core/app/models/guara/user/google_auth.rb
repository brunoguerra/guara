module Guara
  class User
    class GoogleAuth < ActiveRecord::Base
      attr_accessible :identifier, :link, :name, :picture, :gender, :token, :user, :locale

      belongs_to :user, :class_name => "Guara::User"

      self.table_name = 'guara_user_google'

      # google_data
        # :tokeninfo:
        #   issued_to: 761866144670-7skatfbm8mboj2vkqp52if500d1ib53g.apps.googleusercontent.com
        #   audience: 761866144670-7skatfbm8mboj2vkqp52if500d1ib53g.apps.googleusercontent.com
        #   user_id: '114014677648716886439'
        #   scope: https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/plus.me
        #     https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/plus.moments.write
        #     https://www.googleapis.com/auth/plus.profile.agerange.read https://www.googleapis.com/auth/plus.profile.language.read
        #     https://www.googleapis.com/auth/plus.circles.members.read
        #   expires_in: 3594
        #   email: bruno.guerra@gotosunrise.com
        #   verified_email: true
        #   access_type: offline
        # :userinfo:
        #   id: '114014677648716886439'
        #   email: bruno.guerra@gotosunrise.com
        #   verified_email: true
        #   name: Bruno Guerra
        #   given_name: Bruno
        #   family_name: Guerra
        #   link: https://plus.google.com/114014677648716886439
        #   picture: https://lh3.googleusercontent.com/-DFPPIe1JXqA/AAAAAAAAAAI/AAAAAAAAABI/ubFatgjao5I/photo.jpg
        #   gender: male
        #   locale: pt-BR
        #   hd: gotosunrise.com
        # :token_status:
        #   id_token_status:
        #     valid: true
        #     gplus_id: '114014677648716886439'
        #     message: Valid ID Token.
        #   access_token_status:
        #     valid: true
        #     gplus_id: '114014677648716886439'
        #     message: Valid Access Token.
        def self.find_for_email_or_create(email, user_data, google_data)
          if user = User.where(:email => email).first
            user
          else
            begin
              password = Devise.friendly_token[0,20]

              user_data.merge!({:password => password, :password_confirmation => password, :complete => false})
              user = User.new(user_data)
              user_google = User::GoogleAuth.create({
                identifier:   google_data[:userinfo]['id'],
                link:         google_data[:userinfo]['link'],
                gender:       google_data[:userinfo]['gender'],
                name:         google_data[:userinfo]['name'],
                picture:      google_data[:userinfo]['picture'],
                token:        google_data[:token][0..249],
                locale:       google_data[:userinfo]['locale']
              })
              user_google.user = user
              user_google.save!

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
