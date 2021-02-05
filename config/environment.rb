# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

config.action_mailer.default_url_options = { :host => 'instagram-test-aws.herokuapp.com', :protocol => 'https' }
config.action_mailer.perform_deliveries = true
config.action_mailer.delivery_method = :smtp

# ActionMailer::Base.smtp_settings = {
#   :user_name => Rails.application.credentials.dig(:sendgrid, :username),
#   :password => Rails.application.credentials.dig(:sendgrid, :password),
#   :domain => 'instagram-test-aws.herokuapp.com',
#   :address => 'smtp.sendgrid.net',
#   :port => 587,
#   :authentication => :plain,
#   :enable_starttls_auto => true
# }