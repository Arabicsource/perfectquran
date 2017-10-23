# frozen_string_literal: true

require 'rails_helper'

describe 'Comments flag management', type: :request do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:user) { FactoryGirl.create(:member) }
  let(:comment) { FactoryGirl.create(:comment) }
  let(:comment_with_flag) { FactoryGirl.create(:comment, :with_flag) }

  describe 'GET #index' do
    context 'guest' do
      before { get manage_comment_flags_path }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as user
        get manage_comment_flags_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'admin user' do
      before do
        comment
        comment_with_flag
        login_as admin
        get manage_comment_flags_path
      end

      specify { expect(response).to be_successful }
      specify { expect(response.body).not_to include comment.content }
      specify { expect(response.body).to include comment_with_flag.content }
    end
  end
end
