# frozen_string_literal: true

if ENV['COVERAGE']
  require 'simplecov'

  SimpleCov.profiles.define 'starter_app' do
    load_profile 'rails'

    coverage_dir 'coverage'
  end

  SimpleCov.start 'starter_app'
end
