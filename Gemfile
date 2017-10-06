# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap', '~> 4.0.0.beta'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'font-awesome-rails'
gem 'haml'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'kaminari'
gem 'mail_form'
gem 'pg', '~> 0.18'
gem 'popper_js', '~> 1.11.1'
gem 'puma', '~> 3.7'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 5.1.2'
gem 'redcarpet'
gem 'sass-rails', '~> 5.0'
gem 'searchkick'
gem 'turbolinks', '~> 5'
gem 'twitter'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'

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
  gem 'guard-rspec', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', '~> 0.49.1', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'launchy'
  gem 'shoulda-matchers'
end
