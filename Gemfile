# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootsnap', require: false
gem 'bulma-rails', '~> 0.6.2'
gem 'chartkick'
gem 'coffee-rails', '~> 4.2'
gem 'coveralls', require: false
gem 'devise', '4.4.1'
gem 'font-awesome-rails'
gem 'gibbon'
gem 'groupdate'
gem 'haml'
gem 'jbuilder', '~> 2.5'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 5.2.0.rc1'
gem 'rb-gravatar'
gem 'redcarpet', '3.4.0'
gem 'sass-rails', '~> 5.0'
gem 'searchkick'
gem 'sitemap_generator'
gem 'stripe', git: 'https://github.com/stripe/stripe-ruby'
gem 'trix', git: 'https://github.com/bcoia/trix.git'
gem 'turbolinks', '~> 5'
gem 'twitter'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '~> 3.0'

group :development, :test do
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 3.5'
  gem 'spring-commands-rspec'
end

group :development do
  gem 'annotate'
  gem 'brakeman', require: false
  gem 'capistrano', '~> 3.7', '>= 3.7.1'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-rvm'
  gem 'rubocop', '~> 0.52.1', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'stripe-ruby-mock', '~> 2.5.0', require: 'stripe_mock'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'launchy'
  gem 'mocha'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
end
