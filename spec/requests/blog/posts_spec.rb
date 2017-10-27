# frozen_string_literal: true

require 'rails_helper'

describe 'Posts' do
  describe 'GET #index' do
    context 'geust' do
      before do
        @post = FactoryBot.create(:post)
        get blog_path
      end
      specify { expect(response).to be_successful }
      specify { expect(response.body).to include @post.title }
      specify { expect(response.body).to include @post.content }
    end
  end

  describe 'GET #show' do
    describe 'without comments' do
      before do
        @post = FactoryBot.create(:post)
        get blog_post_path(@post.permalink)
      end

      specify { expect(response).to be_successful }
      specify { expect(response.body).to include @post.title }
      specify { expect(response.body).to include @post.content }
      specify { expect(response.body).to include I18n.t('comment.no_comments') }
    end

    describe 'with comments' do
      before do
        @post = FactoryBot.create(:post, :with_comments)
        get blog_post_path(@post.permalink)
      end

      specify { expect(response).to be_successful }
      specify { expect(response.body).to include @post.title }
      specify { expect(response.body).to include @post.content }
      specify do
        expect(response.body).not_to include I18n.t('comment.no_comments')
      end
      specify { expect(response.body).to include @post.comments.first.content }
      specify { expect(response.body).to include 'Flag' }
    end

    describe 'with flagged comments' do
      before do
        @post = FactoryBot.create(:post, :with_flagged_comments)
        get blog_post_path(@post.permalink)
      end

      specify { expect(response).to be_successful }
      specify { expect(response.body).to include @post.title }
      specify { expect(response.body).to include @post.content }
      specify { expect(response.body).to include I18n.t('comment.no_comments') }
      specify do
        expect(response.body).not_to include @post.comments.first.content
      end
      specify { expect(response.body).not_to include 'Flag' }
    end

    describe 'with approved comments' do
      before do
        @post = FactoryBot.create(:post, :with_approved_comments)
        get blog_post_path(@post.permalink)
      end

      specify { expect(response).to be_successful }
      specify { expect(response.body).to include @post.title }
      specify { expect(response.body).to include @post.content }
      specify do
        expect(response.body).not_to include I18n.t('comment.no_comments')
      end
      specify { expect(response.body).to include @post.comments.first.content }
      specify { expect(response.body).not_to include 'Flag' }
    end
  end
end
