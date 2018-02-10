# frozen_string_literal: true

require 'rails_helper'

describe '/devise/registrations/create', type: :request do
  let(:email) { 'example@example.com' }
  let(:valid_params) do
    { account:
      { email: email,
        password: 'password',
        password_confirmation: 'password' } }
  end

  context 'without account' do
    it 'redirects' do
      post account_registration_path, params: valid_params
      expect(response).to redirect_to account_root_path
    end

    it 'creates account' do
      expect { post account_registration_path, params: valid_params }.to change(Account, :count).by(1)
    end

    it 'creates profile' do
      expect { post account_registration_path, params: valid_params }.to change(Profile, :count).by(1)
    end

    it 'sends an email' do
      expect { post account_registration_path, params: valid_params }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'calls mail list subscriber' do
      subscriber = double(:subscriber)

      expect(MailingList::Updater).to(
        receive(:new).with(email).and_return(subscriber)
      )

      expect(subscriber).to receive(:subscribe)

      post account_registration_path, params: valid_params
    end
  end
end
