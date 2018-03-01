# frozen_string_literal: true

require 'rails_helper'

describe 'POST /quran/ayahs/:ayah_id/bookmarks', type: :request do
  let(:ayah) { create :ayah }
  let(:valid_url) { "/quran/ayahs/#{ayah.id}/bookmarks.js" }
  let(:invalid_url) { '/quran/ayahs/0/bookmarks.js' }

  context 'without account' do
    before { post valid_url }

    specify { expect(response).to be_unauthorized }
  end

  context 'with account' do
    before { login_as create :account }

    context 'when successful' do
      it 'returns success' do
        post valid_url

        expect(response).to be_successful
      end

      specify do
        expect { post valid_url }.to change(Bookmark, :count).by(1)
      end
    end

    context 'when failure' do
      it 'returns unprocessable entity' do
        post invalid_url

        expect(response).to have_http_status(422)
      end

      specify do
        expect { post invalid_url }.not_to change(Bookmark, :count)
      end
    end
  end
end
