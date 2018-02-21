# frozen_string_literal: true

# Used in test environment to set headers
# https://stackoverflow.com/questions/15645093/setting-request-headers-in-selenium
class CustomHeadersHelper
  cattr_accessor :headers
end

# This middleware is used in the test environment to add request headers to
# rack_test and selenium-webdriver
class RequestHeaders
  def initialize(app, helper = nil)
    @app = app
    @helper = helper
  end

  def call(env)
    if @helper
      headers = @helper.headers

      if headers.is_a?(Hash)
        headers.each do |key, value|
          env["HTTP_#{key.upcase.tr('-', '_')}"] = value
        end
      end
    end

    @app.call(env)
  end
end
