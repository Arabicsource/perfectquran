# frozen_string_literal: true

require 'rails_helper'

describe 'Settings', type: :request do
  describe 'GET #index' do
    context 'guest' do
      before { get settings_path }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'member' do
      before do
        login_as FactoryBot.create(:member)
        get settings_path
      end
      specify { expect(response).to be_successful }
    end
  end
end
