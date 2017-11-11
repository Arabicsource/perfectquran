# frozen_string_literal: true

require 'rails_helper'

describe 'Commenting', type: :request do
  let(:user) { FactoryBot.create(:member) }
  let(:valid_params) { { comment: FactoryBot.attributes_for(:comment) } }
  let(:empty_params) { { comment: { content: '' } } }

  describe 'on blog posts' do
    let(:blog_post) { FactoryBot.create(:post) }
    let(:post_path) { "/posts/#{blog_post.id}/comments" }

    describe 'POST #create' do
      context 'guest' do
        before { post post_path, params: valid_params }
        specify { expect(response).to redirect_to new_user_session_path }
      end

      context 'registered user' do
        before { login_as user }

        describe 'successful submission' do
          specify do
            expect { post post_path, params: valid_params }
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
end
