# frozen_string_literal: true

# == Schema Information
#
# Table name: ayahs
#
#  id               :bigint(8)        not null, primary key
#  number           :integer
#  character_length :integer
#  surah_id         :bigint(8)
#  page_id          :bigint(8)
#  juz_id           :bigint(8)
#

require 'rails_helper'

RSpec.describe Quran::Ayah, type: :model do
  let(:account) { create :account }
  let(:ayah_1) { Quran::Ayah.first }
  let(:ayah_2) { Quran::Ayah.second }
  let(:ayah_2636) { Quran::Ayah.last }
  let(:uthmani) { Quran::Translation.first }

  describe 'belongs_to associations' do
    it { is_expected.to belong_to :surah }
    it { is_expected.to belong_to :page }
    it { is_expected.to belong_to :juz }
  end

  describe 'has_many associations' do
    it { is_expected.to have_many :bookmarks }
    it { is_expected.to have_many :texts }
    it { is_expected.to have_many :texts_and_translations }
  end

  describe 'primary_text' do
    context 'with guest account' do
      before { Current.account = GuestAccount.new }

      specify { expect(ayah_1.primary_text).to eq 'Noble Quran 1' }
    end

    context 'with account without selected translations' do
      before { Current.account = account }

      specify { expect(ayah_1.primary_text).to eq 'Noble Quran 1' }
    end

    context 'with account with selected translations' do
      before do
        account.account_translations
               .build(translation: uthmani, primary: true)
               .save

        Current.account = account
      end

      specify { expect(ayah_1.primary_text).to eq 'Uthmani 1' }
    end
  end

  specify 'uthmani_text' do
    expect(ayah_1.uthmani_text).to eq 'Uthmani 1'
  end

  specify 'transliterated_text' do
    expect(ayah_1.transliterated_text).to eq 'Transliteration 1'
  end

  specify 'noble_quran_text' do
    expect(ayah_1.noble_quran_text).to eq 'Noble Quran 1'
  end

  specify 'surah_name' do
    expect(ayah_1.surah_name).to eq 'Al-Fatihah'
  end

  describe 'previous' do
    specify { expect(ayah_2.previous).to eq ayah_1 }
    specify { expect(ayah_1.previous).to eq ayah_2636 }
  end

  describe 'next' do
    specify { expect(ayah_1.next).to eq ayah_2 }
    specify { expect(ayah_2636.next).to eq ayah_1 }
  end
end
