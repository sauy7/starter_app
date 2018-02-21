# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('SYSTEM_EMAIL_ADDRESS', 'system@starter_app.com')
  layout 'mailer'
end
