# frozen_string_literal: true

require 'rails_helper'

describe Quran::BookmarksController, type: :request do
  let(:member) { create :member }
  let(:valid_ayah_id) { 1 }
  let(:invalid_ayah_id) { 0 }

  describe 'POST quran_ayah_bookmarks_path' do
    context 'as guest' do
      before { post quran_ayah_bookmark_path(valid_ayah_id) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before { login_as member }

      context 'with valid ayah' do
        it 'redirects' do
          post quran_ayah_bookmark_path(valid_ayah_id)

          expect(response).to redirect_to quran_surah_path('al-fatihah')
        end

        specify 'record is created' do
          expect do
            post quran_ayah_bookmark_path(valid_ayah_id)
          end.to change(Quran::Bookmark, :count).by(1)
        end
      end

      context 'with invalid ayah' do
        it 'is unprocessable' do
          post quran_ayah_bookmark_path(invalid_ayah_id)

          expect(response).to be_unprocessable
        end

        specify 'record is not created' do
          expect do
            post quran_ayah_bookmark_path(invalid_ayah_id)
          end.to_not change(Quran::Bookmark, :count)
        end
      end
    end
  end

  describe 'DELETE quran_ayah_bookmark_path' do
    context 'as guest' do
      before { delete quran_ayah_bookmark_path(valid_ayah_id) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before { login_as member }

      context 'with valid ayah with bookmark' do
        before { create :bookmark, account: member, ayah_id: valid_ayah_id }

        it 'redirects' do
          delete quran_ayah_bookmark_path(valid_ayah_id)

          expect(response).to redirect_to quran_surah_path('al-fatihah')
        end

        specify 'record is deleted' do
          expect { delete quran_ayah_bookmark_path(valid_ayah_id) }
            .to change(Quran::Bookmark, :count).by(-1)
        end
      end

      context 'with valid ayah without bookmark' do
        it 'is unprocessable' do
          delete quran_ayah_bookmark_path(valid_ayah_id)

          expect(response).to be_unprocessable
        end

        specify 'record is not deleted' do
          expect do
            delete quran_ayah_bookmark_path(valid_ayah_id)
          end.to_not change(Quran::Bookmark, :count)
        end
      end

      context 'with invalid ayah' do
        it 'is unprocessable' do
          delete quran_ayah_bookmark_path(invalid_ayah_id)

          expect(response).to be_unprocessable
        end

        specify 'record is not deleted' do
          expect do
            delete quran_ayah_bookmark_path(invalid_ayah_id)
          end.to_not change(Quran::Bookmark, :count)
        end
      end
    end
  end
end
