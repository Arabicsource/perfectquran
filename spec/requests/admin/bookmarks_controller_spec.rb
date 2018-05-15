# frozen_string_literal: true

require 'rails_helper'

describe Admin::BookmarksController, type: :request do
  let(:admin) { create :admin }
  let(:bookmark) { create :bookmark }
  let(:member) { create :member }

  describe 'GET admin_bookmarks_path' do
    context 'as guest' do
      before { get admin_bookmarks_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get admin_bookmarks_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get admin_bookmarks_path
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET admin_bookmark_path' do
    context 'as guest' do
      before { get admin_bookmark_path(bookmark) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get admin_bookmark_path(bookmark)
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get admin_bookmark_path(bookmark)
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'DELETE admin_bookmark_path' do
    context 'as guest' do
      before { delete admin_bookmark_path(bookmark) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        delete admin_bookmark_path(bookmark)
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before { login_as admin }

      context 'when can delete' do
        it 'redirects' do
          delete admin_bookmark_path(bookmark)

          expect(response).to redirect_to admin_bookmarks_path
        end

        specify 'record is deleted' do
          bookmark
          expect { delete admin_bookmark_path(bookmark) }
            .to change(Quran::Bookmark, :count).by(-1)
        end
      end
    end
  end
end
