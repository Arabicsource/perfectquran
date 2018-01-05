# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TwitterAutomater do
  it { expect(TwitterAutomater.new.run!).to be_truthy }
end
