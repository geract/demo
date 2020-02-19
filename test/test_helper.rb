
ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'

if ENV['COVERAGE']
  SimpleCov.start
end

require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/reporters'
require 'capybara/rails'
require 'capybara/minitest'
require 'database_cleaner'
require 'database_cleaner_support'
require 'webmock/minitest'
require_relative 'helpers/login_test_helper'

MiniTest::Reporters.use!
DatabaseCleaner.clean_with :truncation
DatabaseCleaner.strategy = :transaction

FactoryBot::SyntaxRunner.class_eval do
  include ActionDispatch::TestProcess
end

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  include DatabaseCleanerSupport
  # Run tests in parallel with specified workers
  parallelize(workers: 1)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
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
  include DatabaseCleanerSupport
  include LoginTestHelpers

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end
