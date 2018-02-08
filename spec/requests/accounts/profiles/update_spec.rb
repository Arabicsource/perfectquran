# frozen_string_literal: true

require 'rails_helper'

describe '/account/profiles/update', type: :request do
  let :valid_params do
    { profile:
      { name: 'name123', username: 'username123', bio: 'bio123' } }
  end

  let :invalid_params do
    { profile: { name: 'a' * 51, username: 'a' * 51, bio: 'a' * 501 } }
  end

  context 'without account' do
    before { patch account_profile_path, params: valid_params }

    specify { expect(response).to redirect_to new_account_session_path }
  end

  context 'with account' do
    let(:account) { create :account }

    before { login_as account }

    describe 'when success' do
      before { patch account_profile_path, params: valid_params }

      specify { expect(response).to redirect_to account_profile_path }
      specify { expect(account.reload.profile.name).to eq 'name123' }
      specify { expect(account.reload.profile.username).to eq 'username123' }
      specify { expect(account.reload.profile.bio).to eq 'bio123' }
    end

    describe 'when failure' do
      before { patch account_profile_path, params: invalid_params }

      specify { expect(account.reload.profile.name).to be_nil }
      specify { expect(account.reload.profile.username).to be_nil }
      specify { expect(account.reload.profile.bio).to be_nil }
    end
  end
end
