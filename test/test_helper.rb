ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'mocha/mini_test'

class ActiveSupport::TestCase
  include Warden::Test::Helpers

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  def mobile_browser
    Browser::Generic.any_instance.stubs(:mobile?).returns(true)
  end
end
