# frozen_string_literal: true

require 'rails_helper'

describe 'Post management Get #show', type: :request do
  let(:post) { FactoryGirl.create(:post) }

  context 'guest' do
    before { get manage_post_path(post) }

    specify { expect(response).to redirect_to new_user_session_path }
  end

  context 'member' do
    before do
      login_as FactoryGirl.create(:member)
      get manage_post_path(post)
    end

    specify { expect(response).to redirect_to root_path }
  end

  context 'admin' do
    before do
      login_as FactoryGirl.create(:admin)
      get manage_post_path(post)
    end

    specify { expect(response).to be_successful }
  end
end
