# frozen_string_literal: true

require 'rails_helper'

describe 'PATCH Settings::Profiles#update', type: :request do
  let :update_params do
    { profile:
      { name: 'name123', username: 'username123', bio: 'bio123' } }
  end

  let :invalid_params do
    { profile: { name: 'a' * 51, username: 'a' * 51, bio: 'a' * 501 } }
  end

  let :error_messages do
    [
      'Name is too long (maximum is 50 characters)',
      'Username is too long (maximum is 50 characters)',
      'Bio is too long (maximum is 500 characters)'
    ]
  end

  context 'guest' do
    it 'redirects the user to the login page' do
      patch settings_profile_path, params: update_params

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'basic account' do
    describe 'successful submission' do
      it 'redirects to edit' do
        account = create :account
        create :profile, account: account
        login_as account

        patch settings_profile_path, params: update_params

        expect(response).to redirect_to edit_settings_profile_path
      end

      it 'changes the name' do
        account = create :account
        profile = create :profile, account: account, name: 'name'

        login_as account

        expect { patch settings_profile_path, params: update_params }.to(
          change { profile.name }.from('name').to('name123')
        )
      end

      it 'changes the username' do
        account = create :account
        profile = create :profile, account: account, username: 'username'
        login_as account

        expect { patch settings_profile_path, params: update_params }.to(
          change { profile.username }.from('username').to('username123')
        )
      end

      it 'changes the bio' do
        account = create :account
        profile = create :profile, account: account, bio: 'bio'
        login_as account

        expect { patch settings_profile_path, params: update_params }.to(
          change { profile.bio }.from('bio').to('bio123')
        )
      end
    end

    describe 'invalid submission' do
      it 'does not change the name' do
        account = create :account
        profile = create :profile, account: account, name: 'name123'
        login_as account

        patch settings_profile_path, params: invalid_params

        expect(profile.reload.name).to eq 'name123'
      end

      it 'does not change the username' do
        account = create :account
        profile = create :profile, account: account, username: 'username123'
        login_as account

        patch settings_profile_path, params: invalid_params

        expect(profile.reload.username).to eq 'username123'
      end

      it 'does not change the bio' do
        account = create :account
        profile = create :profile, account: account, bio: 'bio123'
        login_as account

        patch settings_profile_path, params: invalid_params

        expect(profile.reload.bio).to eq 'bio123'
      end

      it 'includes error messages' do
        account = create :account
        create :profile, account: account
        login_as account

        patch settings_profile_path, params: invalid_params

        error_messages.each do |message|
          expect(response.body).to include message
        end
      end
    end
  end
end
