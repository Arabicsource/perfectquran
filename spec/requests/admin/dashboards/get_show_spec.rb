# frozen_string_literal: true

require 'rails_helper'

describe 'GET Admin::Dashboards#show', type: :request do
  context 'guest' do
    before { get admin_root_path }

    it 'redirects the user to the login page' do
      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'member' do
    before do
      login_as create :member
      get admin_root_path
    end

    it 'redirects the user to the root page' do
      expect(response).to redirect_to root_path
    end
  end

  context 'admin' do
    before do
      login_as create :admin
      get admin_root_path
    end

    it 'responds successfully' do
      expect(response).to be_successful
    end
  end
end
