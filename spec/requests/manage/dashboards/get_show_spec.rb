# frozen_string_literal: true

require 'rails_helper'

describe 'Management Dashboard GET #show', type: :request do
  context 'guest' do
    before { get manage_root_path }

    it 'redirects the user to the login page' do
      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'member' do
    before do
      login_as FactoryBot.create(:member)
      get manage_root_path
    end

    it 'redirects the user to the root page' do
      expect(response).to redirect_to root_path
    end
  end

  context 'admin' do
    before do
      login_as FactoryBot.create(:admin)
      get manage_root_path
    end

    it 'responds successfully' do
      expect(response).to be_successful
    end
  end
end
