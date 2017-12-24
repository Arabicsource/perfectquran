# frozen_string_literal: true

require 'rails_helper'

describe 'POST Settings::Profiles#create', type: :request do
  let :params do
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
      post accounts_profile_path, params: params

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'member' do
    describe 'successful submission' do
      it 'redirects to root' do
        login_as create :account

        post accounts_profile_path, params: params

        expect(response).to redirect_to new_quran_memory_path
      end

      it 'creates a profile' do
        login_as create :account

        expect { post accounts_profile_path, params: params }.to(
          change(Profile, :count).by(1)
        )
      end

      it 'profile has a name' do
        account = create :account
        login_as account

        post accounts_profile_path, params: params

        expect(account.profile.name).to eq 'name123'
      end

      it 'profile has a username' do
        account = create :account
        login_as account

        post accounts_profile_path, params: params

        expect(account.profile.username).to eq 'username123'
      end

      it 'profile has a bio' do
        account = create :account
        login_as account

        post accounts_profile_path, params: params

        expect(account.profile.bio).to eq 'bio123'
      end
    end

    describe 'invalid submission' do
      it 'does not create a profile' do
        account = create :account
        login_as account

        expect { post accounts_profile_path, params: invalid_params }.not_to(
          change(Profile, :count)
        )
      end

      it 'includes error messages' do
        account = create :account
        login_as account

        post accounts_profile_path, params: invalid_params

        error_messages.each do |message|
          expect(response.body).to include message
        end
      end
    end
  end
end
