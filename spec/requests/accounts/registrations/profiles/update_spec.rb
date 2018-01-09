# frozen_string_literal: true

require 'rails_helper'

describe '/accounts/registrations/profile/update', type: :request do
  let(:account) { create :account }
  let(:uri) { accounts_registrations_profile_path }

  let :valid_params do
    { profile:
      { name: 'name123', username: 'username123', bio: 'bio123' } }
  end

  let :invalid_params do
    { profile: { name: 'a' * 51, username: 'a' * 51, bio: 'a' * 501 } }
  end

  context 'without account' do
    it 'redirects to the login page' do
      patch uri, params: valid_params

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'with account' do
    before { login_as account }

    context 'when success' do
      before { patch uri, params: valid_params }

      specify do
        expect(response).to redirect_to new_accounts_registrations_memory_path
      end

      specify { expect(account.reload.profile.name).to eq 'name123' }
    end

    context 'when failure' do
      before { patch uri, params: invalid_params }

      specify do
        expect(response).not_to(
          redirect_to(new_accounts_registrations_memory_path)
        )
      end

      specify { expect(account.reload.profile.name).to be_nil }
    end
  end
end
