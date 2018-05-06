# frozen_string_literal: true

require 'rails_helper'

describe 'Admin::StatesController' do
  let(:admin) { create :admin }
  let(:city) { create :city }
  let(:country) { countries :usa }
  let(:invalid_params) { { state: { name: '' } } }
  let(:member) { create :member }
  let(:state) { create :state }

  let(:valid_params) do
    { state: { name: 'state123', code: 'ST', country_id: country.id } }
  end

  describe 'GET admin_states_path' do
    context 'as guest' do
      before { get admin_states_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get admin_states_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get admin_states_path
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET admin_state_path' do
    context 'as guest' do
      before { get admin_state_path(state) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get admin_state_path(state)
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get admin_state_path(state)
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET new_admin_state_path' do
    context 'as guest' do
      before { get new_admin_state_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get new_admin_state_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get new_admin_state_path
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET edit_admin_state_path' do
    context 'as guest' do
      before { get edit_admin_state_path(state) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get edit_admin_state_path(state)
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get edit_admin_state_path(state)
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'POST admin_states_path' do
    context 'as guest' do
      before { post admin_states_path, params: valid_params }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        post admin_states_path, params: valid_params
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before { login_as admin }

      context 'with valid params' do
        it 'redirects' do
          post admin_states_path, params: valid_params

          expect(response).to redirect_to admin_states_path
        end

        specify 'record is created' do
          expect do
            post admin_states_path, params: valid_params
          end.to change(State, :count).by(1)
        end
      end

      context 'with invalid params' do
        it 'is unprocessable' do
          post admin_states_path, params: invalid_params

          expect(response).to be_unprocessable
        end

        specify 'record is not created' do
          expect do
            post admin_states_path, params: invalid_params
          end.to_not change(State, :count)
        end
      end
    end
  end

  describe 'PATCH admin_states_path' do
    context 'as guest' do
      before { patch admin_state_path(state), params: valid_params }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        patch admin_state_path(state), params: valid_params
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before { login_as admin }

      context 'with valid params' do
        before { patch admin_state_path(state), params: valid_params }

        specify { expect(response).to redirect_to admin_states_path }
        specify { expect(state.reload.name).to eq 'state123' }
      end

      context 'with invalid params' do
        before { patch admin_state_path(state), params: invalid_params }

        specify { expect(response).to be_unprocessable }
        specify { expect(state.reload.name).to eq 'State' }
      end
    end
  end

  describe 'DELETE admin_state_path' do
    context 'as guest' do
      before { delete admin_state_path(state) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        delete admin_state_path(state)
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before { login_as admin }

      context 'when can delete' do
        it 'redirects' do
          delete admin_state_path(state)

          expect(response).to redirect_to admin_states_path
        end

        specify 'record is deleted' do
          state

          expect { delete admin_state_path(state) }
            .to change(State, :count).by(-1)
        end
      end

      context 'when cannot delete' do
        it 'is unprocessable' do
          delete admin_state_path(city.state)

          expect(response).to be_unprocessable
        end

        specify 'record is not deleted' do
          city
          expect do
            delete admin_state_path(city.state)
          end.to_not change(State, :count)
        end
      end
    end
  end
end
