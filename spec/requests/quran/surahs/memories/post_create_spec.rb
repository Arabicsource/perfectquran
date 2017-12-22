# frozen_string_literal: true

require 'rails_helper'

describe 'POST /quran/ayahs/:ayah_id/memories', type: :request do
  context 'with javascript' do
    let(:surah) { create :surah }
    let(:ayahs) { create_list :ayah, 3, surah: surah }
    let(:valid_url) { "/quran/surahs/#{surah.id}/memories.js" }
    let(:invalid_url) { '/quran/surahs/0/memories.js' }

    context 'as a guest' do
      it 'returns unauthorized' do
        post valid_url

        expect(response).to be_unauthorized
      end

      it 'does not create a memory' do
        expect { post valid_url }.not_to change(Memory, :count)
      end
    end

    context 'as a basic account' do
      before do
        ayahs
        login_as create :account
      end

      context 'success' do
        it 'returns successfully' do
          post valid_url

          expect(response).to be_success
        end

        it 'creates a memory' do
          expect { post valid_url }.to change(Memory, :count).by(3)
        end
      end

      context 'failure' do
        it 'returns as an unprocessable entity' do
          post invalid_url

          expect(response).to have_http_status(422)
        end

        it 'does not create a memory' do
          expect { post invalid_url }.not_to change(Memory, :count)
        end
      end
    end
  end
end
