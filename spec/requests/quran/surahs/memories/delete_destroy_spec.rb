# frozen_string_literal: true

require 'rails_helper'

describe 'DELETE /quran/surahs/:surah_id/memories', type: :request do
  context 'with javascript' do
    let(:surah) { create :surah }
    let(:ayahs) { create_list :ayah, 3, surah: surah }
    let(:valid_url) { "/quran/surahs/#{surah.id}/memories.js" }
    let(:invalid_url) { '/quran/surahs/0/memories.js' }

    context 'as a guest' do
      it 'returns unauthorized' do
        delete valid_url

        expect(response).to be_unauthorized
      end

      it 'does not delete a memory' do
        expect { delete valid_url }.not_to change(Memory, :count)
      end
    end

    context 'as a basic account' do
      before do
        account = create :account
        ayahs.each do |ayah|
          create :memory, account: account, ayah: ayah
        end
        login_as account
      end

      context 'success' do
        it 'returns successfully' do
          delete valid_url

          expect(response).to be_success
        end

        it 'deletes a memory' do
          expect { delete valid_url }.to change(Memory, :count).by(-3)
        end
      end

      context 'failure' do
        it 'returns as an unprocessable entity' do
          delete invalid_url

          expect(response).to have_http_status(422)
        end

        it 'does not delete a memory' do
          expect { delete invalid_url }.not_to change(Memory, :count)
        end
      end
    end
  end
end
