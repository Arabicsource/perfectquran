# frozen_string_literal: true

require 'rails_helper'

describe 'accounts/subscriptions/new' do
  let(:title) { 'New Subscription' }

  before { assign :subscription, build_stubbed(:subscription) }

  it_behaves_like 'a titled view'
end
