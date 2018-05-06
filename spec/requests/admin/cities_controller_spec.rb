# frozen_string_literal: true

require 'rails_helper'

describe Admin::CitiesController, type: :request do
  let(:admin) { create :admin }
  let(:city) { create :city }
  let(:member) { create :member }
  let(:mosque) { create :mosque }
  let(:state) { create :state }
  let(:invalid_params) { { city: { name: '' } } }

  let(:valid_params) do
    { city: { name: 'city123', code: 'CI', state_id: state.id } }
  end

  describe 'GET admin_cities_path' do
    context 'as guest' do
      before { get admin_cities_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get admin_cities_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get admin_cities_path
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET admin_city_path' do
    context 'as guest' do
      before { get admin_city_path(city) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get admin_city_path(city)
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get admin_city_path(city)
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET new_admin_city_path' do
    context 'as guest' do
      before { get new_admin_city_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get new_admin_city_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get new_admin_city_path
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET edit_admin_city_path' do
    let(:city) { create :city }

    context 'as guest' do
      before { get edit_admin_city_path(city) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get edit_admin_city_path(city)
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get edit_admin_city_path(city)
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'POST admin_cities_path' do
    context 'as guest' do
      before { post admin_cities_path, params: valid_params }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        post admin_cities_path, params: valid_params
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before { login_as admin }

      context 'with valid params' do
        it 'redirects' do
          post admin_cities_path, params: valid_params

          expect(response).to redirect_to admin_cities_path
        end

        specify 'record is created' do
          expect do
            post admin_cities_path, params: valid_params
          end.to change(City, :count).by(1)
        end
      end

      context 'with invalid params' do
        it 'is unprocessable' do
          post admin_cities_path, params: invalid_params

          expect(response).to be_unprocessable
        end

        specify 'record is not created' do
          expect do
            post admin_cities_path, params: invalid_params
          end.to_not change(City, :count)
        end
      end
    end
  end

  describe 'PATCH admin_cities_path' do
    context 'as guest' do
      before { patch admin_city_path(city), params: valid_params }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        patch admin_city_path(city), params: valid_params
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before { login_as admin }

      context 'with valid params' do
        before { patch admin_city_path(city), params: valid_params }

        specify { expect(response).to redirect_to admin_cities_path }
        specify { expect(city.reload.name).to eq 'city123' }
      end

      context 'with invalid params' do
        before { patch admin_city_path(city), params: invalid_params }

        specify { expect(response).to be_unprocessable }
        specify { expect(city.reload.name).to eq 'City' }
      end
    end
  end

  describe 'DELETE admin_city_path' do
    context 'as guest' do
      before { delete admin_city_path(city) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        delete admin_city_path(city)
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before { login_as admin }

      context 'when can delete' do
        it 'redirects' do
          delete admin_city_path(city)

          expect(response).to redirect_to admin_cities_path
        end

        specify 'record is deleted' do
          city
          expect { delete admin_city_path(city) }.to change(City, :count).by(-1)
        end
      end

      context 'when cannot delete' do
        it 'is unprocessable' do
          delete admin_city_path(mosque.city)

          expect(response).to be_unprocessable
        end

        specify 'record is not deleted' do
          mosque
          expect do
            delete admin_city_path(mosque.city)
          end.to_not change(City, :count)
        end
      end
    end
  end
end
