# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# ActionMailer::Base.delivery_method = :smtp
# ActionMailer::Base.perform_deliveries
# ActionMailer::Base.smtp_settings = {
# 	addres: "smtp.gmail.com",
# 	port: 465,
# 	domain: "gmail.com",
# 	user_name: ENV['GMAIL_USERNAME'],
# 	password: ENV['GMAIL_PASSWORD'],
# 	authentication: 'plain',
# 	ssl: true,
# 	tsl: true,
# 	enable_starttls_auto: true
# }