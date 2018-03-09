# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'mocha/mini_test'

module ActiveSupport
  class TestCase
    include Warden::Test::Helpers

    # Setup all fixtures in test/fixtures/*.yml for all tests.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
