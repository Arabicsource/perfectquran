# frozen_string_literal: true

require 'rails_helper'

describe '/account/charges/index', type: :request do
  let(:url) { account_charges_path }
  let(:account) { create :account }
  let(:title) { 'Billing History' }

  it_behaves_like 'an account get request'
end
