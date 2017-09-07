require 'rails_helper'

describe 'Post management', type: :request do

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
end