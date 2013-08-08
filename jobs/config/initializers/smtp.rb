  Rails.application.config.action_mailer.smtp_settings = {
    :address              => Guara::SystemPreferences.property("email.smtp.address"),
    :port                 => Guara::SystemPreferences.property("email.smtp.port"),
    :domain               => Guara::SystemPreferences.property("email.smtp.domain"),
    :user_name            => Guara::SystemPreferences.property("email.smtp.default_email.username"),
    :password             => Guara::SystemPreferences.property("email.smtp.default_email.password"),
    :authentication       => Guara::SystemPreferences.property("email.smtp.authentication", 'plain'),
    :enable_starttls_auto => Guara::SystemPreferences.property("email.smtp.tls_auto", '1')=='1' 
  }