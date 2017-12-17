# frozen_string_literal: true

require 'rails_helper'

describe 'PATCH Settings::Accounts#update', type: :request do
  let :update_params do
    { account:
      { name: 'name123', username: 'username123', bio: 'bio123' } }
  end

  let :empty_params do
    { account: { name: '', username: '', bio: '' } }
  end

  let :error_messages do
    [
      'Name can&#39;t be blank',
      'Name is too short (minimum is 3 characters)',
      'Username can&#39;t be blank',
      'Username only Letters, numbers and underscores'
    ]
  end

  context 'guest' do
    it 'redirects the user to the login page' do
      patch settings_account_path, params: update_params

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'member' do
    describe 'successful submission' do
      it 'redirects to edit' do
        login_as create :member

        patch settings_account_path, params: update_params

        expect(response).to redirect_to edit_settings_account_path
      end

      it 'changes the name' do
        member = create :member, name: 'name'

        login_as member

        expect { patch settings_account_path, params: update_params }.to(
          change { member.name }.from('name').to('name123')
        )
      end

      it 'changes the username' do
        member = create :member, username: 'username'

        login_as member

        expect { patch settings_account_path, params: update_params }.to(
          change { member.username }.from('username').to('username123')
        )
      end

      it 'changes the bio' do
        member = create :member, bio: 'bio'

        login_as member

        expect { patch settings_account_path, params: update_params }.to(
          change { member.bio }.from('bio').to('bio123')
        )
      end
    end

    describe 'empty submission' do
      it 'does not change the name' do
        member = create :member, name: 'name123'

        login_as member

        patch settings_account_path, params: empty_params

        expect(member.reload.name).to eq 'name123'
      end

      it 'does not change the username' do
        member = create :member, username: 'username123'

        login_as member

        patch settings_account_path, params: empty_params

        expect(member.reload.username).to eq 'username123'
      end

      it 'does not change the bio' do
        member = create :member, bio: 'bio123'

        login_as member

        patch settings_account_path, params: empty_params

        expect(member.reload.bio).to eq 'bio123'
      end

      it 'includes error messages' do
        login_as create :member

        patch settings_account_path, params: empty_params

        error_messages.each do |message|
          expect(response.body).to include message
        end
      end
    end
  end
end
