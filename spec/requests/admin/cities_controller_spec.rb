# frozen_string_literal: true

require 'rails_helper'

describe 'Admin::CitiesController' do
  let(:account) { create :account }
  let(:admin) { create :account, :as_admin }
  let(:state) { create :state }
  let(:invalid_params) { { city: { name: '' } } }
  let(:valid_params) { { city: { name: 'city123', code: 'CI', state_id: state.id } } }

  describe 'GET admin_cities_path' do
    context 'when not logged in' do
      before { get admin_cities_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'when logged in as a non-admin' do
      before do
        login_as account
        get admin_cities_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'when logged in as admin' do
      before do
        login_as admin
        get admin_cities_path
      end

      specify { expect(response).to be_successful }
    end

    context 'when logged in as admin on mobile' do
      before do
        mobile_browser
        login_as admin
        get admin_cities_path
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET new_admin_city_path' do
    context 'when not logged in' do
      before { get new_admin_city_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'when logged in as a non-admin' do
      before do
        login_as account
        get new_admin_city_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'when logged in as admin' do
      before do
        login_as admin
        get new_admin_city_path
      end

      specify { expect(response).to be_successful }
    end

    context 'when logged in as admin on mobile' do
      before do
        mobile_browser
        login_as admin
        get new_admin_city_path
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'POST admin_cities_path' do
    context 'when not logged in' do
      before { post admin_cities_path, params: valid_params }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'when logged in as a non-admin' do
      before do
        login_as account
        post admin_cities_path, params: valid_params
      end

      specify { expect(response).to redirect_to root_path }
    end
  
    context 'when logged in as an admin' do
      before { login_as admin }

      context 'when params are valid' do
        it 'redirects to admin_cities_path' do
          post admin_cities_path, params: valid_params

          expect(response).to redirect_to admin_cities_path
        end

        specify 'City record is created' do
          expect do
            post admin_cities_path, params: valid_params
          end.to change(City, :count).by(1)
        end
      end

      context 'when params are invalid' do
        specify 'City record is not created' do
          expect do
            post admin_cities_path, params: invalid_params
          end.to_not change(City, :count)
        end
      end
    end
  end
end
