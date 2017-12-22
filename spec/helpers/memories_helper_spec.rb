# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MemoriesHelper, type: :helper do
  describe '#memorized?' do
    it 'returns true if account has memorized the ayah' do
      account = create :account
      ayah = create :ayah
      create :memory, ayah: ayah, account: account

      expect(helper.memorized?(ayah, account)).to be_truthy
    end

    it 'returns false if account has not memorized the ayah' do
      account = create :account
      ayah = create :ayah

      expect(helper.memorized?(ayah, account)).to be_falsey
    end
  end

  describe '#surah_memorized?' do
    it 'returns true if all ayahs in surah have been memorized' do
      surah = create :surah
      account = create :account
      ayahs = create_list :ayah, 3, surah: surah

      ayahs.each do |ayah|
        create :memory, ayah: ayah, account: account
      end

      expect(helper.surah_memorized?(surah, account)).to be_truthy
    end

    it 'returns false if any ayah in surah is not memorized' do
      surah = create :surah
      account = create :account

      expect(helper.surah_memorized?(surah, account)).to be_falsey
    end
  end
end
