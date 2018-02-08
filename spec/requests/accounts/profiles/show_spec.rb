# frozen_string_literal: true

require 'rails_helper'

describe '/account/profiles/show', type: :request do
  let(:url) { account_profile_path }
  let(:account) { create :account }
  let!(:profile) { create :profile, account: account }
  let(:title) { 'Profile' }

  it_behaves_like 'an account get request'
end
