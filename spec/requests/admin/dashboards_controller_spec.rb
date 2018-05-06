# frozen_string_literal: true

require 'rails_helper'

describe Admin::DashboardsController, type: :request do
  describe 'GET admin_root_path' do
    context 'as guest' do
      before { get admin_root_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as create :member
        get admin_root_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as create :admin
        get admin_root_path
      end

      specify { expect(response).to be_successful }
    end
  end
end
