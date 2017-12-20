# frozen_string_literal: true

require 'rails_helper'

describe 'POST /quran/ayahs/:ayah_id/memories', type: :request do
  context 'with javascript' do
    let(:ayah) { create :ayah }
    let(:valid_url) { "/quran/ayahs/#{ayah.id}/memories.js" }
    let(:invalid_url) { '/quran/ayahs/0/memories.js' }

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
      before { login_as create :account }

      context 'success' do
        it 'returns successfully' do
          post valid_url

          expect(response).to be_success
        end

        it 'creates a memory' do
          expect { post valid_url }.to change(Memory, :count).by(1)
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
