# frozen_string_literal: true

module CustomAssertions
  def assert_last_email(recipient, subject)
    last_email = ActionMailer::Base.deliveries.last
    last_email.to == Array.wrap(recipient) && subject == last_email.subject
  end
end
