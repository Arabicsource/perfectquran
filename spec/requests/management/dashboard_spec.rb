# frozen_string_literal: true

require 'rails_helper'

describe 'Management Dashboard', type: :request do
  describe 'GET #index' do
    context 'guest' do
      before { get manage_dashboards_path }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as FactoryGirl.create(:member)
        get manage_dashboards_path
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin user' do
      before do
        login_as FactoryGirl.create(:admin)
        get manage_dashboards_path
      end
      specify { expect(response).to be_successful }
    end
  end
end
