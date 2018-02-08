# frozen_string_literal: true

require 'rails_helper'

describe '/account/subscriptions/new', type: :request do
  let(:url) { new_account_subscription_path }
  let(:account) { create :account }
  let(:title) { 'New Subscription' }

  it_behaves_like 'an account get request'
end
