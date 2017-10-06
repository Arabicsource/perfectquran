# frozen_string_literal: true

require 'rails_helper'

describe 'Post management', type: :request do
  let(:admin) { FactoryGirl.create(:user, :confirmed, :admin) }
  let(:category) { FactoryGirl.create(:category) }
  let(:user) { FactoryGirl.create(:user, :confirmed) }
  let(:post_obj) { FactoryGirl.create(:post) }
  let(:post_attributes) { FactoryGirl.attributes_for(:post) }
  let(:params) { { post: post_attributes.merge(category_id: category.id) } }
  let(:update_params) do
    { post: { title: 'UpdatedTitle', content: 'UpdatedContent' } }
  end

  describe 'GET #index' do
    context 'guest' do
      before { get manage_posts_path }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as FactoryGirl.create(:user, :confirmed)
        get manage_posts_path
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin user' do
      before do
        @post = FactoryGirl.create(:post)
        login_as FactoryGirl.create(:user, :confirmed, :admin)
        get manage_posts_path
      end
      specify { expect(response).to be_successful }
      specify { expect(response.body).to include @post.title }
    end
  end

  describe 'GET #show' do
    let(:post) { FactoryGirl.create(:post) }

    context 'guest' do
      before { get manage_post_path(post) }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as FactoryGirl.create(:user, :confirmed)
        get manage_post_path(post)
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin user' do
      before do
        login_as FactoryGirl.create(:user, :confirmed, :admin)
        get manage_post_path(post)
      end
      specify { expect(response).to be_successful }
      specify { expect(response.body).to include post.title }
      specify { expect(response.body).to include post.content }
    end
  end

  describe 'GET #new' do
    context 'geust' do
      before { get new_manage_post_path }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as FactoryGirl.create(:user, :confirmed)
        get new_manage_post_path
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin user' do
      before do
        login_as FactoryGirl.create(:user, :confirmed, :admin)
        get new_manage_post_path
      end
      specify { expect(response).to be_successful }
      specify { expect(response.body).to include 'new_post' }
    end
  end

  describe 'POST #create' do
    context 'guest' do
      before { post '/manage/posts', params: params }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as user
        post '/manage/posts', params: params
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin' do
      before { login_as admin }

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

  describe 'Get #edit' do
    context 'guest' do
      before { get edit_manage_post_path(post_obj) }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as FactoryGirl.create(:user, :confirmed)
        get edit_manage_post_path(post_obj)
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin user' do
      before do
        login_as FactoryGirl.create(:user, :confirmed, :admin)
        get edit_manage_post_path(post_obj)
      end
      specify { expect(response).to be_successful }
      specify { expect(response.body).to include 'edit_post' }
    end
  end

  describe 'PATCH #update' do
    context 'guest' do
      before { patch '/manage/posts/' + post_obj.id.to_s }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as FactoryGirl.create(:user, :confirmed)
        patch '/manage/posts/' + post_obj.id.to_s,
              params: { post: post_attributes }
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin' do
      before { login_as FactoryGirl.create(:user, :confirmed, :admin) }

      describe 'successful submission' do
        before do
          patch '/manage/posts/' + post_obj.id.to_s, params: update_params
          post_obj.reload
        end
        specify { expect(response).to redirect_to manage_posts_path }
        specify { expect(post_obj.title).to eq update_params[:post][:title] }
        specify do
          expect(post_obj.content).to eq update_params[:post][:content]
        end
      end

      describe 'empty submission' do
        before do
          empty_params = { post: { title: '', content: '' } }
          patch '/manage/posts/' + post_obj.id.to_s, params: empty_params
          post_obj.reload
        end
        specify { expect(response.body).to include 'Title can&#39;t be blank' }
        specify do
          expect(response.body).to include 'Content can&#39;t be blank'
        end
      end
    end
  end
end
