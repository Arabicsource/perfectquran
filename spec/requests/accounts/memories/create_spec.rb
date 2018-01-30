# frozen_string_literal: true

require 'rails_helper'

describe 'POST /accounts/memory', type: :request do
  let(:account) { create :account }
  let(:valid_url) { '/accounts/memory.js' }
  let!(:surahs) { create_list :surah, 5, :with_ayahs }

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

      expect(response).to be_success
    end

    it 'changes memory count' do
      expect { post valid_url }.to change(Memory, :count).by(15)
    end
  end
end
