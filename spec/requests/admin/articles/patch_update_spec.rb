# frozen_string_literal: true

require 'rails_helper'

describe 'PATCH Admin::Articles#update', type: :request do
  let :update_params do
    { article:
      { title: 'title123', content: 'content123', visibility: 'published' } }
  end

  let :empty_params do
    { article: { title: '', content: '' } }
  end

  let :error_messages do
    [
      'Title can&#39;t be blank',
      'Content can&#39;t be blank'
    ]
  end

  context 'guest' do
    it 'redirects the user to the login page' do
      article = create :article

      patch "/admin/articles/#{article.id}", params: update_params

      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'member' do
    it 'redirects the user to the root page' do
      article = create :article
      login_as create(:member)

      patch "/admin/articles/#{article.id}", params: update_params

      expect(response).to redirect_to root_path
    end
  end

  context 'admin' do
    describe 'successful submission' do
      it 'redirects to show' do
        article = create :article

        login_as create :admin

        patch "/admin/articles/#{article.id}", params: update_params

        expect(response).to redirect_to admin_articles_path
      end

      it 'changes the title' do
        article = create :article, title: 'title'

        login_as create :admin

        patch "/admin/articles/#{article.id}", params: update_params

        expect { article.reload.title }.to(
          change { article.title }.from('title').to('title123')
        )
      end

      it 'changes the content' do
        article = create :article, content: 'content'

        login_as create :admin

        patch "/admin/articles/#{article.id}", params: update_params

        expect { article.reload.content }.to(
          change { article.content }.from('content').to('content123')
        )
      end

      it 'changes the visibility' do
        article = create :article, visibility: 'draft'

        login_as create :admin

        patch "/admin/articles/#{article.id}", params: update_params

        expect { article.reload.visibility }.to(
          change { article.visibility }.from('draft').to('published')
        )
      end
    end

    describe 'empty submission' do
      it 'does not change the title' do
        article = create :article

        login_as create :admin

        patch "/admin/articles/#{article.id}", params: empty_params

        expect { article.reload.title }.not_to(change { article.title })
      end

      it 'does not change the content' do
        article = create :article

        login_as create :admin

        patch "/admin/articles/#{article.id}", params: empty_params

        expect { article.reload.content }.not_to(change { article.content })
      end

      it 'does not change the content' do
        article = create :article

        login_as create :admin

        patch "/admin/articles/#{article.id}", params: empty_params

        expect { article.reload.visibility }
          .not_to(change { article.visibility })
      end

      it 'includes error messages' do
        article = create :article

        login_as create :admin

        patch "/admin/articles/#{article.id}", params: empty_params

        error_messages.each do |message|
          expect(response.body).to include message
        end
      end
    end
  end
end
