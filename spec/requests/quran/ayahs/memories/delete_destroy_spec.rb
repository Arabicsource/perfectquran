# frozen_string_literal: true

require 'rails_helper'

describe 'DELETE /quran/ayahs/:ayah_id/memories', type: :request do
  context 'with javascript' do
    let(:ayah) { create :ayah }
    let(:valid_url) { "/quran/ayahs/#{ayah.id}/memories.js" }
    let(:invalid_url) { '/quran/ayahs/0/memories.js' }

    context 'as a guest' do
      before { create :memory, ayah: ayah }

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
        create :memory, account: account, ayah: ayah
        login_as account
      end

      context 'success' do
        it 'returns successfully' do
          delete valid_url

          expect(response).to be_success
        end

        it 'deletes a memory' do
          expect { delete valid_url }.to change(Memory, :count).by(-1)
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
