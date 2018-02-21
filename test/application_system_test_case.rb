# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # include ShowMeTheCookies

  def setup
    I18n.locale = :en
    host! "http://#{Capybara.server_host}:#{Capybara.server_port}"
  end

  options = {}
  if ENV['CHROME'].nil?
    options = options.merge(desired_capabilities: {
                              chromeOptions: { args: %w[headless disable-gpu] }
                            })
  end
  driven_by :selenium,
            using: :chrome, screen_size: [1400, 1400], options: options
end
