ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address: 'smtp.mail.us-west-2.awsapps.com',
  domain: 'matchi-gourmet.com',
  port: 465,
  user_name: ENV['WORKMAIL_USERNAME'],
  password: ENV['WORKMAIL_PASSWORD'],
  ssl: true
}
