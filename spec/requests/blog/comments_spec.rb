# frozen_string_literal: true

require 'rails_helper'

describe 'Commenting', type: :request do
  let(:blog_post) { FactoryGirl.create(:post) }
  let(:post_path) { "/blog/posts/#{blog_post.id}/comments" }
  let(:user) { FactoryGirl.create(:user, :confirmed) }
  let(:params) { { comment: FactoryGirl.attributes_for(:comment) } }
  let(:empty_params) { { comment: { content: '' } } }

  describe 'POST #create' do
    context 'guest' do
      before { post post_path, params: params }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'registered user' do
      before { login_as user }

      describe 'successful submission' do
        specify do
          expect { post post_path, params: params }
            .to change(Comment, :count)
        end
      end

      describe 'empty submission' do
        specify do
          expect { post post_path, params: empty_params }
            .not_to change(Comment, :count)
        end
      end
    end
  end
end
