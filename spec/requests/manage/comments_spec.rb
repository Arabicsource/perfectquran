# frozen_string_literal: true

require 'rails_helper'

describe 'Comment management', type: :request do
  let(:admin) { FactoryBot.create(:admin) }
  let(:user) { FactoryBot.create(:member) }
  let(:comment) { FactoryBot.create(:comment) }
  let(:delete_path) { "/manage/comments/#{comment.id}" }

  describe 'GET #index' do
    context 'guest' do
      before { get manage_comments_path }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as user
        get manage_comments_path
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin user' do
      before do
        comment
        login_as admin
        get manage_comments_path
      end
      specify { expect(response).to be_successful }
    end
  end

  describe 'GET #show' do
    context 'guest' do
      before { get manage_comment_path(comment) }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as user
        get manage_comment_path(comment)
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin user' do
      before do
        login_as admin
        get manage_comment_path(comment)
      end
      specify { expect(response).to be_successful }
      specify { expect(response.body).to include comment.content }
    end
  end

  describe 'DELETE #destroy' do
    context 'guest' do
      before { delete delete_path }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as user
        delete delete_path
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin' do
      before do
        login_as admin
        delete delete_path
      end
      specify { expect(response).to redirect_to manage_comments_path }
      specify { expect(response.body).not_to include comment.content }
    end
  end
end
