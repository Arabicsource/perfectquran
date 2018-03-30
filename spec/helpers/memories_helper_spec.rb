# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MemoriesHelper, type: :helper do
  let(:account) { create :account }
  let(:ayah) { Ayah.first }
  let(:surah) { Quran::Surah.first }

  describe 'memorized?' do
    it 'returns true if account has memorized the ayah' do
      create :memory, ayah: ayah, account: account

      expect(helper.memorized?(ayah, account)).to be_truthy
    end

    it 'returns false if account has not memorized the ayah' do
      expect(helper.memorized?(ayah, account)).to be_falsey
    end
  end

  describe 'surah_memorized?' do
    it 'returns true if all ayahs in surah have been memorized' do
      surah.ayahs.each do |ayah|
        create :memory, ayah: ayah, account: account
      end

      expect(helper.surah_memorized?(surah, account)).to be_truthy
    end

    it 'returns false if any ayah in surah is not memorized' do
      expect(helper.surah_memorized?(surah, account)).to be_falsey
    end
  end
end
