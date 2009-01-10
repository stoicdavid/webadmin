require 'smtp_tls'

ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => "25",
  :domain => "localhost.localdomain",
  :authentication => :plain,
  :user_name => "stoicdavid",
  :password  => "fat719110"
}