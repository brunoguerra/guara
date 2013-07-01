  GuaraCmgb::Application.config.action_mailer.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => 'localhost:3000',
    :user_name            => "maciel@woese.com",
    :password             => "franciscomaciel",
    :authentication       => 'plain',
    :enable_starttls_auto => true  
  }