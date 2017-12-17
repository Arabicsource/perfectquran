# frozen_string_literal: true

require 'rails_helper'

describe 'Post Content::Comments#create', type: :request do
  let :valid_params do
    article = create :article
    comment_attributes = attributes_for(:comment)
                         .merge(article_id: article.id)
    { comment: comment_attributes }
  end

  let :empty_params do
    { comment: { content: '' } }
  end

  let :error_messages do
    [
      'Content can&#39;t be blank'
    ]
  end

  context 'guest' do
    it 'redirects the user to the login page' do
      article = create :article

      post "/content/articles/#{article.id}/comments", params: valid_params

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'member' do
    describe 'successful submission' do
      it 'redirects to article' do
        article = create :article
        login_as create :admin

        post "/content/articles/#{article.id}/comments", params: valid_params

        expect(response).to redirect_to content_article_path(article.permalink)
      end

      it 'increases count by 1' do
        article = create :article
        url = "/content/articles/#{article.id}/comments"
        login_as create :admin

        expect { post url, params: valid_params }
          .to change(Comment, :count).by(1)
      end
    end

    describe 'empty submission' do
      it 'does not change count' do
        article = create :article
        url = "/content/articles/#{article.id}/comments"
        login_as create :admin

        expect { post url, params: empty_params }.not_to change(Comment, :count)
      end

      it 'includes error messages' do
        article = create :article
        login_as create :admin

        post "/content/articles/#{article.id}/comments", params: empty_params

        error_messages.each do |message|
          expect(response.body).to include message
        end
      end
    end
  end
end
