ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'

if ENV['COVERAGE']
  SimpleCov.start
end

require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/rails'
require 'capybara/rails'
require 'capybara/minitest'
require 'webmock/minitest'
require_relative 'helpers/login_test_helper'
require_relative 'helpers/api_headers_helper'

FactoryBot::SyntaxRunner.class_eval do
  include ActionDispatch::TestProcess
end

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  parallelize(workers: 1)
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end

class ActionDispatch::IntegrationTest
  include Warden::Test::Helpers
  include Capybara::DSL
  include Capybara::Minitest::Assertions
  include LoginTestHelpers
  include ApiHeadersHelper

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end
