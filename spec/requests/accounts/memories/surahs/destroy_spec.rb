# frozen_string_literal: true

require 'rails_helper'

describe 'POST /accounts/memory/surahs', type: :request do
  let(:surah) { create :surah, :with_ayahs }
  let(:account) { create :account }
  let(:valid_url) { "/accounts/memory/surahs/#{surah.id}/memory.js" }

  before { surah.ayahs.each { |a| create :memory, ayah: a, account: account } }

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
      expect { delete valid_url }.to change(Memory, :count).by(-3)
    end
  end
end
