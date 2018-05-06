# frozen_string_literal: true

require 'rails_helper'

describe Admin::CountriesController, type: :request do
  let(:admin) { create :admin }
  let(:member) { create :member }
  let(:country) { create :country }
  let(:state) { create :state, country: country }
  let(:invalid_params) { { country: { name: '' } } }

  let(:valid_params) do
    { country: { name: 'country123', code: 'CO' } }
  end

  describe 'GET admin_countries_path' do
    context 'as guest' do
      before { get admin_countries_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get admin_countries_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get admin_countries_path
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET admin_city_path' do
    context 'as guest' do
      before { get admin_country_path(country) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get admin_country_path(country)
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get admin_country_path(country)
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET new_admin_country_path' do
    context 'as guest' do
      before { get new_admin_country_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get new_admin_country_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get new_admin_country_path
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET edit_admin_country_path' do
    context 'as guest' do
      before { get edit_admin_country_path(country) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get edit_admin_country_path(country)
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get edit_admin_country_path(country)
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'POST admin_countries_path' do
    context 'as guest' do
      before { post admin_countries_path, params: valid_params }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        post admin_countries_path, params: valid_params
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before { login_as admin }

      context 'with valid params' do
        it 'redirects' do
          post admin_countries_path, params: valid_params

          expect(response).to redirect_to admin_countries_path
        end

        specify 'record is created' do
          expect do
            post admin_countries_path, params: valid_params
          end.to change(Country, :count).by(1)
        end
      end

      context 'with invalid params' do
        it 'is unprocessable' do
          post admin_countries_path, params: invalid_params

          expect(response).to be_unprocessable
        end

        specify 'record is not created' do
          expect do
            post admin_countries_path, params: invalid_params
          end.to_not change(Country, :count)
        end
      end
    end
  end

  describe 'PATCH admin_countries_path' do
    context 'as guest' do
      before { patch admin_country_path(country), params: valid_params }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        patch admin_country_path(country), params: valid_params
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before { login_as admin }

      context 'with valid params' do
        before { patch admin_country_path(country), params: valid_params }

        specify { expect(response).to redirect_to admin_countries_path }
        specify { expect(country.reload.name).to eq 'country123' }
      end

      context 'with invalid params' do
        before { patch admin_country_path(country), params: invalid_params }

        specify { expect(response).to be_unprocessable }
        specify { expect(country.reload.name).to eq 'Country' }
      end
    end
  end

  describe 'DELETE admin_country_path' do
    context 'as guest' do
      before { delete admin_country_path(country) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        delete admin_country_path(country)
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before { login_as admin }

      context 'when can delete' do
        it 'redirects' do
          delete admin_country_path(country)

          expect(response).to redirect_to admin_countries_path
        end

        specify 'record is deleted' do
          country

          expect { delete admin_country_path(country) }
            .to change(Country, :count).by(-1)
        end
      end

      context 'when cannot delete' do
        it 'is unprocessable' do
          delete admin_country_path(state.country)

          expect(response).to be_unprocessable
        end

        specify 'record is not deleted' do
          state
          expect do
            delete admin_country_path(state.country)
          end.to_not change(Country, :count)
        end
      end
    end
  end
end
