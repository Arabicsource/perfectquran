# frozen_string_literal: true

require 'rails_helper'

describe 'Post management PATCH #update', type: :request do
  let(:blog_post) { FactoryGirl.create(:post) }
  let(:params) do
    { post: { title: 'UpdatedTitle', content: 'UpdatedContent' } }
  end

  context 'guest' do
    before { patch "/manage/posts/#{blog_post.id}", params: params }

    specify { expect(response).to redirect_to new_user_session_path }
  end

  context 'member' do
    before do
      login_as FactoryGirl.create(:member)
      patch "/manage/posts/#{blog_post.id}", params: params
    end

    specify { expect(response).to redirect_to root_path }
  end

  context 'admin' do
    before { login_as FactoryGirl.create(:admin) }

    describe 'successful submission' do
      before do
        patch "/manage/posts/#{blog_post.id}", params: params
        blog_post.reload
      end
      specify { expect(response).to redirect_to manage_posts_path }
      specify { expect(blog_post.title).to eq params[:post][:title] }
      specify do
        expect(blog_post.content).to eq params[:post][:content]
      end
    end

    describe 'empty submission' do
      before do
        empty_params = { post: { title: '', content: '' } }
        patch "/manage/posts/#{blog_post.id}", params: empty_params
      end
      specify { expect(response.body).to include 'Title can&#39;t be blank' }
      specify do
        expect(response.body).to include 'Content can&#39;t be blank'
      end
    end
  end
end
