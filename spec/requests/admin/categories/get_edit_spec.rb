# frozen_string_literal: true

require 'rails_helper'

describe 'GET Admin::Categories#edit', type: :request do
  context 'guest' do
    it 'redirects the user to the login page' do
      category = create :category

      get edit_admin_category_path(category)

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'member' do
    it 'redirects the user to the root page' do
      login_as create :member
      category = create :category

      get edit_admin_category_path(category)

      expect(response).to redirect_to root_path
    end
  end

  context 'admin' do
    it 'responds successfully' do
      login_as create :admin
      category = create :category

      get edit_admin_category_path(category)

      expect(response).to be_successful
    end
  end
end
