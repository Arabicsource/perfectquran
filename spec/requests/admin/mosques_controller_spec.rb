# frozen_string_literal: true

require 'rails_helper'

describe 'Admin::MosquesController' do
  let(:account) { create :account }
  let(:admin) { create :account, :as_admin }
  let(:city) { create :city }
  let(:invalid_params) { { mosque: { name: '' } } }

  let(:valid_params) do
    { mosque:
      { name: 'name123',
        phone: 'phone123',
        email: 'email123',
        street: 'street123',
        city_id: city.id,
        zip_code: 'zip_code123',
        website: 'website123'
      } }
  end

  describe 'GET admin_mosques_path' do
    context 'when not logged in' do
      before { get admin_mosques_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'when logged in as a non-admin' do
      before do
        login_as account
        get admin_mosques_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'when logged in as admin' do
      before do
        login_as admin
        get admin_mosques_path
      end

      specify { expect(response).to be_successful }
    end

    context 'when logged in as admin on mobile' do
      before do
        mobile_browser
        login_as admin
        get admin_mosques_path
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET new_admin_mosque_path' do
    context 'when not logged in' do
      before { get new_admin_mosque_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'when logged in as a non-admin' do
      before do
        login_as account
        get new_admin_mosque_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'when logged in as admin' do
      before do
        login_as admin
        get new_admin_mosque_path
      end

      specify { expect(response).to be_successful }
    end

    context 'when logged in as admin on mobile' do
      before do
        mobile_browser
        login_as admin
        get new_admin_mosque_path
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'POST /admin/mosques' do
    context 'when not logged in' do
      before { post '/admin/mosques', params: valid_params }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'when logged in as a non-admin' do
      before do
        login_as account
        post '/admin/mosques', params: valid_params
      end

      specify { expect(response).to redirect_to root_path }
    end
  
    context 'when logged in as an admin' do
      before { login_as admin }

      context 'when params are valid' do
        it 'redirects to admin_mosques_path' do
          post '/admin/mosques', params: valid_params

          expect(response).to redirect_to admin_mosques_path
        end

        specify 'Mosque record is created' do
          expect do
            post admin_mosques_path, params: valid_params
          end.to change(Mosque, :count).by(1)
        end
      end

      context 'when params are invalid' do
        specify 'Mosque record is not created' do
          expect do
            post admin_mosques_path, params: invalid_params
          end.to_not change(Mosque, :count)
        end
      end
    end
  end
end
