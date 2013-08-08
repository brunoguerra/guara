begin
  Rails.application.config.action_mailer.smtp_settings = {
    :address              => Guara::SystemPreference.property("email.smtp.address"),
    :port                 => Guara::SystemPreference.property("email.smtp.port"),
    :domain               => Guara::SystemPreference.property("email.smtp.domain"),
    :user_name            => Guara::SystemPreference.property("email.smtp.default_email.username"),
    :password             => Guara::SystemPreference.property("email.smtp.default_email.password"),
    :authentication       => Guara::SystemPreference.property("email.smtp.authentication", 'plain'),
    :enable_starttls_auto => Guara::SystemPreference.property("email.smtp.tls_auto", '1')=='1' 
  }

rescue Exception => e
  puts e.message
end