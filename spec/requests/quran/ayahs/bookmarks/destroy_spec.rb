# frozen_string_literal: true

require 'rails_helper'

describe 'DELETE /quran/ayahs/:ayah_id/bookmarks', type: :request do
  let(:ayah) { create :ayah }
  let(:valid_url) { "/quran/ayahs/#{ayah.id}/bookmarks.js" }
  let(:invalid_url) { '/quran/ayahs/0/bookmarks.js' }
  let(:account) { create :account }
  let!(:bookmark) { create :bookmark, account: account, bookmarkable: ayah }

  context 'without account' do
    before { delete valid_url }

    specify { expect(response).to be_unauthorized }
  end

  context 'as a basic account' do
    before { login_as account }

    context 'when success' do
      it 'returns success' do
        delete valid_url

        expect(response).to be_successful
      end

      it 'deletes a bookmark' do
        expect { delete valid_url }.to change(Quran::Bookmark, :count).by(-1)
      end
    end

    context 'when failure' do
      it 'returns unprocessable entity' do
        delete invalid_url

        expect(response).to have_http_status(422)
      end

      it 'does not delete a bookmark' do
        expect { delete invalid_url }.not_to change(Quran::Bookmark, :count)
      end
    end
  end
end
