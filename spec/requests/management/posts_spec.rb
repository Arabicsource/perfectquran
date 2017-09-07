require 'rails_helper'

describe 'Post management', type: :request do
  let(:post_attributes) { FactoryGirl.attributes_for(:post) }
  let(:params) { { post: post_attributes } }

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
      before { post "/manage/posts" }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as FactoryGirl.create(:user, :confirmed)
        post '/manage/posts'
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin' do
      before { login_as FactoryGirl.create(:user, :confirmed, :admin) }
      
      describe 'successful submission' do
        specify do
          expect { post "/manage/posts", { params: params } }.to change(Post, :count)
          expect(response).to redirect_to manage_posts_path
        end
      end
      
      describe 'empty submission' do
        specify do
          empty_params  = { post: {title: '', content: ''} } 
          expect { post '/manage/posts', { params: empty_params } }.not_to change(Post, :count)
          expect(response.body).to include 'Title can&#39;t be blank'
          expect(response.body).to include 'Content can&#39;t be blank'
        end
      end
    end
  end
end