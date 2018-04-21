# frozen_string_literal: true

require 'rails_helper'

describe 'Devise::RegistrationsController' do
  let(:account) { create :account }
  let(:invalid_params) { { account: { email: '' } } }

  let(:valid_params) do
    { account:
      { email: 'example@perfectquran.co',
        password: 'password',
        password_confirmation: 'password' } }
  end

  describe 'GET new_account_registration_path' do
    context 'when not logged in' do
      before { get new_account_registration_path }

      specify { expect(response).to be_successful }
    end

    context 'when not logged in on mobile' do
      before do
        mobile_browser
        get new_account_registration_path
      end

      specify { expect(response).to be_successful }
    end

    context 'when logged in' do
      before do
        login_as account
        get new_account_registration_path
      end

      specify { expect(response).to redirect_to root_path }
    end
  end

  describe 'POST create' do
    context 'when not logged in' do
      context 'when params are invalid' do
        specify 'No account record is created' do
          expect do
            post account_registration_path, params: invalid_params
          end.to_not change(Account, :count)
        end
      end

      context 'when params are valid' do
        it 'redirect to root_path' do
          post account_registration_path, params: valid_params

          expect(response).to redirect_to root_path
        end

        specify 'Account record is created' do
          expect do
            post account_registration_path, params: valid_params
          end.to change(Account, :count).by(1)
        end

        specify 'Profile record is created' do
          expect do
            post account_registration_path, params: valid_params
          end.to change(Profile, :count).by(1)
        end

        specify 'EmailPreference record is created' do
          expect do
            post account_registration_path, params: valid_params
          end.to change(Account::EmailPreference, :count).by(1)
        end

        specify 'Email is sent' do
          expect do
            post account_registration_path, params: valid_params
          end.to change(ActionMailer::Base.deliveries, :count).by(1)
        end
      end
    end

    context 'when logged in' do
      before { login_as account }

      specify 'No account record is created' do
        expect do
          post account_registration_path, params: valid_params
        end.to_not change(Account, :count)
      end
    end
  end
end
