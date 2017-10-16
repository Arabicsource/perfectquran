# frozen_string_literal: true

require 'rails_helper'

describe 'Posts' do
  let(:post) { FactoryGirl.create(:post) }
  let(:post_with_comments) { FactoryGirl.create(:post, :with_comments) }
  let(:post_with_flagged_comments) { FactoryGirl.create(:post, :with_flagged_comments) }
  let(:post_with_approved_comments) { FactoryGirl.create(:post, :with_approved_comments) }  

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
    describe 'without comments' do
      before { get blog_post_path(post.permalink) }
      specify { expect(response).to be_successful }
      specify { expect(response.body).to include post.title }
      specify { expect(response.body).to include post.content }
      specify { expect(response.body).to include I18n.t('comment.no_comments') }
    end

    describe 'with comments' do
      before { get blog_post_path(post_with_comments.permalink) }
      specify { expect(response).to be_successful }
      specify { expect(response.body).to include post_with_comments.title }
      specify { expect(response.body).to include post_with_comments.content }
      specify { expect(response.body).not_to include I18n.t('comment.no_comments') }
      specify { expect(response.body).to include post_with_comments.comments.first.content }
      specify { expect(response.body).to include 'Flag' }
    end

    describe 'with flagged comments' do
      before { get blog_post_path(post_with_flagged_comments.permalink) }
      specify { expect(response).to be_successful }
      specify { expect(response.body).to include post_with_flagged_comments.title }
      specify { expect(response.body).to include post_with_flagged_comments.content }
      specify { expect(response.body).to include I18n.t('comment.no_comments') }
      specify { expect(response.body).not_to include post_with_flagged_comments.comments.first.content }
      specify { expect(response.body).not_to include 'Flag' }
    end

    describe 'with approved comments' do
      before { get blog_post_path(post_with_approved_comments.permalink) }
      specify { expect(response).to be_successful }
      specify { expect(response.body).to include post_with_approved_comments.title }
      specify { expect(response.body).to include post_with_approved_comments.content }
      specify { expect(response.body).not_to include I18n.t('comment.no_comments') }
      specify { expect(response.body).to include post_with_approved_comments.comments.first.content }
      specify { expect(response.body).not_to include 'Flag' }
    end
  end
end
