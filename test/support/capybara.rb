# frozen_string_literal: true

Capybara.default_driver = :rack_test
Capybara.default_max_wait_time = 2 # seconds
Capybara.server_host = '127.0.0.1'
Capybara.server_port = 55_000
