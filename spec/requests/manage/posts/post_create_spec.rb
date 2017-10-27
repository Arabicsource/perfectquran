# frozen_string_literal: true

require 'rails_helper'

describe 'Post management POST #create', type: :request do
  let(:post_attributes) { FactoryBot.attributes_for(:post) }
  let(:params) { { post: post_attributes.merge(category_name: category.name) } }
  let(:category) { FactoryBot.create(:category) }

  context 'guest' do
    before { post '/manage/posts', params: params }

    specify { expect(response).to redirect_to new_user_session_path }
  end

  context 'member' do
    before do
      login_as FactoryBot.create(:member)
      post '/manage/posts', params: params
    end

    specify { expect(response).to redirect_to root_path }
  end

  context 'admin' do
    before { login_as FactoryBot.create(:admin) }

    describe 'successful submission' do
      specify do
        expect { post '/manage/posts', params: params }
          .to change(Post, :count)
        expect(response).to redirect_to manage_posts_path
      end
    end

    describe 'empty submission' do
      specify do
        empty_params = { post: { title: '', content: '', category_id: '' } }
        expect { post '/manage/posts', params: empty_params }
          .not_to change(Post, :count)
        expect(response.body).to include 'Title can&#39;t be blank'
        expect(response.body).to include 'Content can&#39;t be blank'
        expect(response.body).to include 'Category must exist'
      end
    end
  end
end
