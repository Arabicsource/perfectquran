# frozen_string_literal: true

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'app/jobs/application_job.rb'
  add_filter 'app/mailers/application_mailer.rb'
  add_filter 'app/channels/application_cable/channel.rb'
  add_filter 'app/channels/application_cable/connection.rb'
end

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end

require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.global_fixtures = :all
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include RequestSpecHelper, type: :request
  config.include MobileHelper, type: :request
  config.include Warden::Test::Helpers, type: :feature
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
