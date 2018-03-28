# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TwitterAutomater do
  fixtures :translations

  let(:account) { create :account }
  let!(:connection) do
    create(
      :connection, account: account, translation: translations(:translation_1)
    )
  end

  it do
    expect(TwitterAutomater.new(frequency: :daily_active).call).to be_truthy
  end
end
