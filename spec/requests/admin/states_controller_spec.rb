# frozen_string_literal: true

require 'rails_helper'

describe 'Admin::StatesController' do
  let(:account) { create :account }
  let(:admin) { create :account, :as_admin }
  let(:country) { countries :usa }
  let(:invalid_params) { { state: { name: '' } } }

  let(:valid_params) do
    { state: { name: 'state123', code: 'ST', country_id: country.id } }
  end

  describe 'GET admin_states_path' do
    context 'when not logged in' do
      before { get admin_states_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'when logged in as a non-admin' do
      before do
        login_as account
        get admin_states_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'when logged in as admin' do
      before do
        login_as admin
        get admin_states_path
      end

      specify { expect(response).to be_successful }
    end

    context 'when logged in as admin on mobile' do
      before do
        mobile_browser
        login_as admin
        get admin_states_path
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET new_admin_state_path' do
    context 'when not logged in' do
      before { get new_admin_state_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'when logged in as a non-admin' do
      before do
        login_as account
        get new_admin_state_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'when logged in as admin' do
      before do
        login_as admin
        get new_admin_state_path
      end

      specify { expect(response).to be_successful }
    end

    context 'when logged in as admin on mobile' do
      before do
        mobile_browser
        login_as admin
        get new_admin_state_path
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'POST admin_states_path' do
    context 'when not logged in' do
      before { post admin_states_path, params: valid_params }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'when logged in as a non-admin' do
      before do
        login_as account
        post admin_states_path, params: valid_params
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'when logged in as an admin' do
      before { login_as admin }

      context 'when params are valid' do
        it 'redirects to admin_states_path' do
          post admin_states_path, params: valid_params

          expect(response).to redirect_to admin_states_path
        end

        specify 'State record is created' do
          expect do
            post admin_states_path, params: valid_params
          end.to change(State, :count).by(1)
        end
      end

      context 'when params are invalid' do
        specify 'State record is not created' do
          expect do
            post admin_states_path, params: invalid_params
          end.to_not change(State, :count)
        end
      end
    end
  end
end
