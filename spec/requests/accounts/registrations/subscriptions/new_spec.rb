# frozen_string_literal: true

require 'rails_helper'

describe '/accounts/registrations/subscriptions/new', type: :request do
  let(:url) { new_accounts_registrations_subscription_path }
  let(:account) { create :account }
  let(:title) { 'Subscribe to PerfectQuran' }

  it_behaves_like 'an account get request'
end
