# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read('.ruby-version').strip

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'bundler', '~> 1.16.1'
# gem 'delayed_job_active_record'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
gem 'komponent'
# # Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'
gem 'pg', '>= 0.18', '< 2.0'
gem 'premailer-rails', github: 'fphilipe/premailer-rails'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.0.rc1'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger
  # console
  gem 'byebug'
  gem 'factory_bot_rails'
end

group :development do
  gem 'annotate'
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'guard'
  gem 'guard-livereload', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'lol_dba'
  gem 'rack-livereload'
  gem 'rack-mini-profiler', require: false
  gem 'railroady'
  gem 'rails_best_practices'
  gem 'rubocop', require: false
  gem 'rubycritic', require: false
  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'strong_migrations'
  # Access an interactive console on exception pages or by calling 'console'
  # anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.15'
  # gem 'capybara-extensions'
  gem 'capybara_minitest_spec'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
  gem 'database_cleaner'
  gem 'minitest', '5.10.3'
  gem 'minitest-bang'
  gem 'minitest-spec-rails'
  # gem 'mocha'
  gem 'selenium-webdriver'
  # gem 'show_me_the_cookies'
  gem 'simplecov', require: false
  # gem 'vcr'
  # gem 'webmock'
end

group :production do
  gem 'exception_notification', github: 'sauy7/exception_notification'
  gem 'octokit'
end
