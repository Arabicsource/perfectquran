# frozen_string_literal: true

RSpec::Matchers.define :have_title do |expected|
  match do |response|
    response.body.include? "#{expected} | PerfectQuran"
  end
end

RSpec::Matchers.define :have_path do |expected|
  match do |response|
    response.request.original_fullpath == expected
  end
end
