# frozen_string_literal: true

require 'rails_helper'

describe 'Post management GET #index', type: :request do
  context 'guest' do
    before { get manage_posts_path }

    specify { expect(response).to redirect_to new_user_session_path }
  end

  context 'member' do
    before do
      login_as FactoryGirl.create(:member)
      get manage_posts_path
    end

    specify { expect(response).to redirect_to root_path }
  end

  context 'admin user' do
    before do
      login_as FactoryGirl.create(:admin)
      get manage_posts_path
    end

    specify { expect(response).to be_successful }
  end
end
