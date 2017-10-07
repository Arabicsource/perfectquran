# frozen_string_literal: true

require 'rails_helper'

describe 'User management', type: :request do
  let(:admin) { FactoryGirl.create(:user, :confirmed, :admin) }
  let(:user) { FactoryGirl.create(:user, :confirmed) }
  let(:user_obj) { FactoryGirl.create(:user) }
  
  describe 'GET #index' do
    context 'guest' do
      before { get manage_users_path }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as user
        get manage_users_path
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin user' do
      before do
        login_as admin
        get manage_users_path
      end
      specify { expect(response).to be_successful }
    end
  end

  describe 'GET #show' do
    context 'guest' do
      before { get manage_user_path(user_obj) }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as user
        get manage_user_path(user_obj)
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin user' do
      before do
        login_as admin
        get manage_user_path(user_obj)
      end
      specify { expect(response).to be_successful }
      specify { expect(response.body).to include user_obj.username }
    end
  end
end
