# frozen_string_literal: true

namespace :specify do
  require 'rubocop/rake_task'

  RuboCop::RakeTask.new(:rubocop)
  RSpec::Core::RakeTask.new(:spec)
end

task :specify do
  %w[rubocop spec].each { |task| Rake::Task["specify:#{task}"].invoke }
end
