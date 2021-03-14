# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => 'camzillajs',
  :password => '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',
  :domain => 'sezmereviews.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
