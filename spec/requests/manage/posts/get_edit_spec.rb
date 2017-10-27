# frozen_string_literal: true

require 'rails_helper'

describe 'Post management GET #edit', type: :request do
  let(:blog_post) { FactoryBot.create(:post) }

  context 'guest' do
    before { get edit_manage_post_path(blog_post) }

    specify { expect(response).to redirect_to new_user_session_path }
  end

  context 'member' do
    before do
      login_as FactoryBot.create(:member)
      get edit_manage_post_path(blog_post)
    end

    specify { expect(response).to redirect_to root_path }
  end

  context 'admin' do
    before do
      login_as FactoryBot.create(:admin)
      get edit_manage_post_path(blog_post)
    end

    specify { expect(response).to be_successful }
  end
end
