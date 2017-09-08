# frozen_string_literal: true

require 'rails_helper'

describe 'User management', type: :request do
  describe 'GET #index' do
    context 'guest' do
      before { get manage_users_path }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as FactoryGirl.create(:user, :confirmed)
        get manage_users_path
      end
      specify { expect(response).to redirect_to root_path }
    end
  end
end
