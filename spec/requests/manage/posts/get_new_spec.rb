# frozen_string_literal: true

require 'rails_helper'

describe 'Post management GET #new', type: :request do
  context 'geust' do
    before { get new_manage_post_path }

    specify { expect(response).to redirect_to new_user_session_path }
  end

  context 'member' do
    before do
      login_as FactoryBot.create(:member)
      get new_manage_post_path
    end

    specify { expect(response).to redirect_to root_path }
  end

  context 'admin' do
    before do
      login_as FactoryBot.create(:admin)
      get new_manage_post_path
    end

    specify { expect(response).to be_successful }
  end
end
