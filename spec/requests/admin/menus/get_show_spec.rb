# frozen_string_literal: true

require 'rails_helper'

describe 'GET Admin::Menus#show', type: :request do
  context 'guest' do
    it 'redirects the user to the login page' do
      menu = create :menu

      get admin_menu_path(menu)

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'member' do
    it 'redirects the user to the root page' do
      login_as create :member
      menu = create :menu

      get admin_menu_path(menu)

      expect(response).to redirect_to root_path
    end
  end

  context 'admin' do
    it 'responds successfully' do
      login_as create :admin
      menu = create :menu

      get admin_menu_path(menu)

      expect(response).to be_successful
    end
  end
end
