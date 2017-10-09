# frozen_string_literal: true

require 'rails_helper'

describe 'General Settings', type: :request do
  let(:user) { FactoryGirl.create(:user, :confirmed) }

  describe 'GET #edit' do
    context 'guest' do
      before { get edit_settings_general_path }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as user
        get edit_settings_general_path
      end
      specify { expect(response).to be_successful }
    end
  end
end
