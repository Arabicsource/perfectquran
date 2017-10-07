# frozen_string_literal: true

require 'rails_helper'

describe 'Posts' do
  let(:post) { FactoryGirl.create(:post) }

  describe 'GET #index' do
    context 'geust' do
      before do
        post
        get blog_path
      end
      specify { expect(response).to be_successful }
      specify { expect(response.body).to include post.title }
      specify { expect(response.body).to include post.content }
    end
  end

  describe 'GET #show' do
    before { get blog_post_path(post.permalink) }
    specify { expect(response).to be_successful }
    specify { expect(response.body).to include post.title }
    specify { expect(response.body).to include post.content }
  end
end
