# frozen_string_literal: true

require 'rails_helper'

describe Admin::MosquesController, type: :request do
  let(:admin) { create :admin }
  let(:member) { create :member }
  let(:mosque) { create :mosque }
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
        website: 'website123' } }
  end

  describe 'GET admin_mosques_path' do
    context 'as guest' do
      before { get admin_mosques_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get admin_mosques_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get admin_mosques_path
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET admin_mosque_path' do
    context 'as guest' do
      before { get admin_mosque_path(mosque) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get admin_mosque_path(mosque)
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get admin_mosque_path(mosque)
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET new_admin_mosque_path' do
    context 'as guest' do
      before { get new_admin_mosque_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get new_admin_mosque_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get new_admin_mosque_path
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET edit_admin_mosque_path' do
    context 'as guest' do
      before { get edit_admin_mosque_path(mosque) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get edit_admin_mosque_path(mosque)
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get edit_admin_mosque_path(mosque)
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'POST admin_mosques_path' do
    context 'as guest' do
      before { post admin_mosques_path, params: valid_params }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        post admin_mosques_path, params: valid_params
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before { login_as admin }

      context 'with valid params' do
        it 'redirects' do
          post admin_mosques_path, params: valid_params

          expect(response).to redirect_to admin_mosques_path
        end

        specify 'record is created' do
          expect do
            post admin_mosques_path, params: valid_params
          end.to change(Mosque, :count).by(1)
        end
      end

      context 'with invalid params' do
        it 'is unprocessable' do
          post admin_mosques_path, params: invalid_params

          expect(response).to be_unprocessable
        end

        specify 'record is not created' do
          expect do
            post admin_mosques_path, params: invalid_params
          end.to_not change(Mosque, :count)
        end
      end
    end
  end

  describe 'PATCH admin_mosque_path' do
    context 'as guest' do
      before { patch admin_mosque_path(mosque), params: valid_params }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        patch admin_mosque_path(mosque), params: valid_params
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before { login_as admin }

      context 'with valid params' do
        before { patch admin_mosque_path(mosque), params: valid_params }

        specify { expect(response).to redirect_to admin_mosques_path }
        specify { expect(mosque.reload.name).to eq 'name123' }
      end

      context 'with invalid params' do
        before { patch admin_mosque_path(mosque), params: invalid_params }

        specify { expect(response).to be_unprocessable }
        specify { expect(mosque.reload.name).to eq 'Mosque' }
      end
    end
  end

  describe 'DELETE admin_mosque_path' do
    context 'as guest' do
      before { delete admin_mosque_path(mosque) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        delete admin_mosque_path(mosque)
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before { login_as admin }

      context 'when can delete' do
        it 'redirects' do
          delete admin_mosque_path(mosque)

          expect(response).to redirect_to admin_mosques_path
        end

        specify 'record is deleted' do
          mosque

          expect { delete admin_mosque_path(mosque) }
            .to change(Mosque, :count).by(-1)
        end
      end
    end
  end
end
