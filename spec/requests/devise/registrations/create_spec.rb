# frozen_string_literal: true

require 'rails_helper'

describe '/devise/registrations/create', type: :request do
  let(:valid_params) do
    { account:
      { email: 'example@example.com',
        password: 'password',
        password_confirmation: 'password' } }
  end

  context 'without account' do
    it 'redirects' do
      post '/', params: valid_params
      expect(response).to redirect_to edit_accounts_registrations_profile_path
    end

    it 'creates account' do
      expect { post '/', params: valid_params }.to change(Account, :count).by(1)
    end

    it 'creates profile' do
      expect { post '/', params: valid_params }.to change(Profile, :count).by(1)
    end
  end
end
