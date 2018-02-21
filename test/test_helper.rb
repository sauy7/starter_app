# frozen_string_literal: true

require 'support/coverage'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'capybara/rails'
# require 'mocha/mini_test'
require 'support/capybara'
require 'support/capybara_macros'
require 'support/custom_assertions'
require 'support/test_helpers'
# require 'support/vcr'
# require 'webmock/minitest'

DatabaseCleaner.strategy = :transaction
DatabaseCleaner.clean

module ActiveSupport
  class TestCase
    include CustomAssertions
    include TestHelpers

    def setup
      DatabaseCleaner.start
      # Webmock.disable_net_connect!(allow_localhost: true)
    end

    def teardown
      DatabaseCleaner.clean
      # Webmock.reset!
    end
  end
end

module ActionDispatch
  class IntegrationTest
    include Capybara::DSL
    include CapybaraMacros

    def teardown
      Capybara.reset_sessions!
    end
  end
end
