# frozen_string_literal: true

require 'rails_helper'

describe 'POST /account/memory/surahs', type: :request do
  let(:surah) { create :surah, :with_ayahs }
  let(:account) { create :account }
  let(:valid_url) { "/account/memory/surahs/#{surah.id}/memory.js" }

  context 'without account' do
    it 'returns unauthorized' do
      post valid_url

      expect(response).to be_unauthorized
    end

    it 'does not change memory count' do
      expect { post valid_url }.not_to change(Memory, :count)
    end
  end

  context 'with account and successful' do
    before { login_as account }

    it 'returns successfully' do
      post valid_url

      expect(response).to be_successful
    end

    it 'changes memory count' do
      expect { post valid_url }.to change(Memory, :count).by(3)
    end
  end
end
