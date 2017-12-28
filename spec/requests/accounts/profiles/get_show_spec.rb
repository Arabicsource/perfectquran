# frozen_string_literal: true

require 'rails_helper'

describe 'GET /accounts/profile/show', type: :request do
  let(:url) { accounts_profile_path }
  let(:account) { create :account }
  let!(:profile) { create :profile, account: account }

  it_behaves_like 'an account get request'
end
