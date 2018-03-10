# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TwitterAutomater do
  let(:account) { create :account }
  let!(:connection) { create :connection, account: account }

  it { expect(TwitterAutomater.new.call).to be_truthy }
end
