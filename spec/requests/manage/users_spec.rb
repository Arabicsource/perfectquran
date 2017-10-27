# frozen_string_literal: true

require 'rails_helper'

describe 'User management', type: :request do
  let(:admin) { FactoryBot.create(:admin) }
  let(:member) { FactoryBot.create(:member) }
  let(:user_obj) { FactoryBot.create(:user) }

  describe 'GET #index' do
    context 'guest' do
      before { get manage_users_path }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'member' do
      before do
        login_as member
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

    context 'member' do
      before do
        login_as member
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
