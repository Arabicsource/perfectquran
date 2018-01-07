# frozen_string_literal: true

require 'rails_helper'

describe '/accounts/profiles/show', type: :request do
  let(:url) { accounts_profile_path }
  let(:account) { create :account }
  let!(:profile) { create :profile, account: account }
  let(:title) { 'Profile' }

  it_behaves_like 'an account get request'

  context 'without profile' do
    let(:account_without_profile) { create :account }

    before { login_as account_without_profile }

    specify { expect { get url }.to change(Profile, :count).by(1) }
  end
end
