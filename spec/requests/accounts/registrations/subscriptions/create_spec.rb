# frozen_string_literal: true

require 'rails_helper'

describe 'POST Accounts::Registrations::Subscriptions#create', type: :request do
  let(:account) { create :account }
  let(:klass) { Subscription }
  let(:url) { accounts_registrations_subscription_path }
  let(:redirect_path) { accounts_profile_path }
  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:valid_params) { { stripeToken: stripe_helper.generate_card_token } }
  let(:invalid_params) { { stripeToken: '' } }

  before { stripe_helper.create_plan id: 1 }

  it_behaves_like 'an account post request'
end
