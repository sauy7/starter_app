# frozen_string_literal: true

require 'request_headers'

module CapybaraHeaderHelpers
  def add_headers(custom_headers)
    if Capybara.current_driver == :rack_test
      custom_headers.each do |name, value|
        page.driver.browser.header(name, value)
      end
    else
      CustomHeadersHelper.headers = custom_headers
    end
  end

  def clear_headers(names)
    if Capybara.current_driver == :rack_test
      names.each do |name|
        page.driver.browser.header(name, nil)
      end
    else
      CustomHeadersHelper.headers = {}
    end
  end
end
