ActionMailer::Base.smtp_settings = {
  domain: 'instagram-test-aws.herokuapp.com',
  address:        "smtp.sendgrid.net",
  port:            587,
  authentication: :plain,
  user_name:      Rails.application.credentials.dig(:sendgrid, :username),
  password:       Rails.application.credentials.dig(:sendgrid, :password)
}