# frozen_string_literal: true

require 'rails_helper'

describe 'PATCH Admin::Articles#update', type: :request do
  context 'guest' do
    it 'redirects the user to the login page' do
      article = create :article

      delete "/admin/articles/#{article.id}"

      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'member' do
    it 'redirects the user to the root page' do
      article = create :article
      login_as create(:member)

      delete "/admin/articles/#{article.id}"

      expect(response).to redirect_to root_path
    end
  end

  context 'admin' do
    describe 'successful submission' do
      it 'redirects to show' do
        article = create :article

        login_as create :admin

        delete "/admin/articles/#{article.id}"

        expect(response).to redirect_to admin_articles_path
      end

      it 'changes the visibility' do
        article = create :article, visibility: 'draft'

        login_as create :admin

        delete "/admin/articles/#{article.id}"

        expect { article.reload.visibility }.to(
          change { article.visibility }.from('draft').to('trash')
        )
      end
    end
  end
end
