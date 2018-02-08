# frozen_string_literal: true

require 'rails_helper'

describe 'DELETE /account/memory/ayahs', type: :request do
  let(:surah) { create :surah }
  let(:account) { create :account }
  let(:ayah) { create :ayah, surah: surah }
  let(:valid_url) { "/account/memory/ayahs/#{ayah.id}/memory.js" }

  before { create :memory, ayah: ayah, account: account }

  context 'without account' do
    it 'returns unauthorized' do
      delete valid_url

      expect(response).to be_unauthorized
    end

    it 'does not change memory count' do
      expect { delete valid_url }.not_to change(Memory, :count)
    end
  end

  context 'with account and successful' do
    before { login_as account }

    it 'returns successfully' do
      delete valid_url

      expect(response).to be_successful
    end

    it 'changes memory count' do
      expect { delete valid_url }.to change(Memory, :count).by(-1)
    end
  end
end
