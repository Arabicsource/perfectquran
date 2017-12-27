# frozen_string_literal: true

require 'rails_helper'

describe 'accounts/subscriptions/new' do
  let(:title) { 'New Subscription' }

  it_behaves_like 'a titled view'
end
