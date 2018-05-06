# frozen_string_literal: true

require 'rails_helper'

describe Admin::ArticlesController, type: :request do
  let(:admin) { create :admin }
  let(:article) { create :article, title: 'titleabc' }
  let(:category) { create :category }
  let(:comment) { create :comment }
  let(:member) { create :member }
  let(:invalid_params) { { article: { title: '' } } }

  let(:valid_params) do
    {
      article:
        { title: 'title123', content: 'content123', category_id: category.id }
    }
  end

  describe 'GET admin_articles_path' do
    context 'as guest' do
      before { get admin_articles_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get admin_articles_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get admin_articles_path
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET admin_article_path' do
    context 'as guest' do
      before { get admin_article_path(article) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get admin_article_path(article)
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get admin_article_path(article)
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET new_admin_article_path' do
    context 'as guest' do
      before { get new_admin_article_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get new_admin_article_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get new_admin_article_path
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET edit_admin_article_path' do
    context 'as guest' do
      before { get edit_admin_article_path(article) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get edit_admin_article_path(article)
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get edit_admin_article_path(article)
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'POST admin_articles_path' do
    context 'as guest' do
      before { post admin_articles_path, params: valid_params }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        post admin_articles_path, params: valid_params
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before { login_as admin }

      context 'with valid params' do
        it 'redirects' do
          post admin_articles_path, params: valid_params

          expect(response).to redirect_to admin_articles_path
        end

        specify 'record is created' do
          expect do
            post admin_articles_path, params: valid_params
          end.to change(Article, :count).by(1)
        end
      end

      context 'with invalid params' do
        it 'is unprocessable' do
          post admin_articles_path, params: invalid_params

          expect(response).to be_unprocessable
        end

        specify 'record is not created' do
          expect do
            post admin_articles_path, params: invalid_params
          end.to_not change(Article, :count)
        end
      end
    end
  end

  describe 'PATCH admin_articles_path' do
    context 'as guest' do
      before { patch admin_article_path(article), params: valid_params }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        patch admin_article_path(article), params: valid_params
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before { login_as admin }

      context 'with valid params' do
        before { patch admin_article_path(article), params: valid_params }

        specify { expect(response).to redirect_to admin_articles_path }
        specify { expect(article.reload.title).to eq 'title123' }
      end

      context 'with invalid params' do
        before { patch admin_article_path(article), params: invalid_params }

        specify { expect(response).to be_unprocessable }
        specify { expect(article.reload.title).to eq 'titleabc' }
      end
    end
  end

  describe 'DELETE admin_article_path' do
    context 'as guest' do
      before { delete admin_article_path(article) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        delete admin_article_path(article)
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before { login_as admin }

      context 'when can delete' do
        it 'redirects' do
          delete admin_article_path(article)

          expect(response).to redirect_to admin_articles_path
        end

        specify 'record is deleted' do
          article

          expect { delete admin_article_path(article) }
            .to change(Article, :count).by(-1)
        end
      end

      context 'when cannot delete' do
        it 'is unprocessable' do
          delete admin_article_path(comment.article)

          expect(response).to be_unprocessable
        end

        specify 'record is not deleted' do
          comment
          expect do
            delete admin_article_path(comment.article)
          end.to_not change(Article, :count)
        end
      end
    end
  end
end
