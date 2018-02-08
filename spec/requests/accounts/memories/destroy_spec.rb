# frozen_string_literal: true

require 'rails_helper'

describe 'DELETE /account/memory', type: :request do
  let(:account) { create :account }
  let(:valid_url) { '/account/memory.js' }

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
      create_list :surah, 5, :with_ayahs

      Quran::Ayah.all.each do |ayah|
        Memory.create(account: account, ayah: ayah)
      end

      expect { delete valid_url }.to change(Memory, :count).by(-15)
    end
  end
end
