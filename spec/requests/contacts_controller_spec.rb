# frozen_string_literal: true

require 'rails_helper'

describe ContactsController, type: :request do
  let(:invalid_params) { { contact: { name: '' } } }

  let(:valid_params) do
    {
      contact:
        { name: 'name123', email: 'email123', body: 'body123' }
    }
  end

  describe 'GET new_contact_path' do
    before { get new_contact_path }

    specify { expect(response).to be_successful }
    specify { expect(response).to have_title 'Contact' }
  end

  describe 'POST contact_path' do
    context 'with valid params' do
      it 'redirects' do
        post contact_path, params: valid_params

        expect(response).to redirect_to new_contact_path
      end

      specify 'email is delivered' do
        expect do
          post contact_path, params: valid_params
        end.to change(ActionMailer::Base.deliveries, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'is redirects' do
        post contact_path, params: invalid_params

        expect(response).to redirect_to new_contact_path
      end

      specify 'email is not delivered' do
        expect do
          post contact_path, params: invalid_params
        end.to_not change(ActionMailer::Base.deliveries, :count)
      end
    end
  end
end
