

ActionMailer::Base.smtp_settings = {
  :address => "smtp.uservers.net",
  :port => "2525",
  :domain => "americanneurolab.com",
  :authentication => :plain,
  :user_name => "info@americanneurolab.com",
  :password  => "ventana"
}