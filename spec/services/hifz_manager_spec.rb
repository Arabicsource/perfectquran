# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HifzManager do
  let(:account) { create :account }
  let(:hifz_manager) { HifzManager.new(account) }

  describe '#memory_count' do
    it "returns the account's total memory count" do
      ayahs = create_list :ayah, 3, character_length: 2
      ayahs.each { |a| create :memory, account: account, ayah: a }

      expect(hifz_manager.memory_length).to eq 6
    end
  end

  describe '#not_memorized_surahs' do
    it 'returns surahs that are not memorized' do
      # create :surah, :with_ayahs, transliterated_name: 'first'
      # second = create :surah, :with_ayahs, transliterated_name: 'second'
      # create :surah, :with_ayahs, transliterated_name: 'third'
      # create :memory, account: account, ayah: second.ayahs.first

      expect(hifz_manager.not_memorized_surahs.map(&:id))
        .to eq (1..114).to_a
    end
  end

  describe '#not_memorized_surahs' do
    it 'returns surahs that are partially memorized' do
      first = create :surah, :with_ayahs, transliterated_name: 'first'
      create :surah, :with_ayahs, transliterated_name: 'second'
      third = create :surah, :with_ayahs, transliterated_name: 'third'
      create :memory, account: account, ayah: first.ayahs.last
      create :memory, account: account, ayah: third.ayahs.first

      expect(hifz_manager.partially_memorized_surahs.map(&:transliterated_name))
        .to eq %w[first third]
    end
  end

  describe '#not_memorized_surahs' do
    it 'returns surahs that are completely memorized' do
      first = create :surah, :with_ayahs, transliterated_name: 'first'
      create :surah, :with_ayahs, transliterated_name: 'second'
      third = create :surah, :with_ayahs, transliterated_name: 'third'
      first.ayahs.each { |a| create :memory, account: account, ayah: a }
      third.ayahs.each { |a| create :memory, account: account, ayah: a }

      expect(hifz_manager.memorized_surahs.map(&:transliterated_name))
        .to eq %w[first third]
    end
  end
end
