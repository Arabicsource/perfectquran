# frozen_string_literal: true

require 'rails_helper'

describe Admin::CitiesController, type: :request do
  let(:admin) { create :admin }
  let(:member) { create :member }

  describe 'GET admin_connections_path' do
    context 'as guest' do
      before { get admin_connections_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get admin_connections_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get admin_connections_path
      end

      specify { expect(response).to be_successful }
    end
  end
end
