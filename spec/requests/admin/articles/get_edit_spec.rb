# frozen_string_literal: true

require 'rails_helper'

describe 'GET Admin::Articles#edit', type: :request do
  context 'guest' do
    it 'redirects the user to the login page' do
      article = create :article

      get edit_admin_article_path(article)

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'member' do
    it 'redirects the user to the root page' do
      login_as create :member
      article = create :article

      get edit_admin_article_path(article)

      expect(response).to redirect_to root_path
    end
  end

  context 'admin' do
    it 'responds successfully' do
      login_as create :admin
      article = create :article

      get edit_admin_article_path(article)

      expect(response).to be_successful
    end
  end
end
