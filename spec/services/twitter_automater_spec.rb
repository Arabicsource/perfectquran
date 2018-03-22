# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TwitterAutomater do
  let(:account) { create :account }
  let!(:connection) { create :connection, account: account }

  it do
    expect(TwitterAutomater.new(frequency: :daily_active).call).to be_truthy
  end
end
