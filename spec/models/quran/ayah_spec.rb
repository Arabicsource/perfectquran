# frozen_string_literal: true

# == Schema Information
#
# Table name: ayahs
#
#  id               :integer          not null, primary key
#  number           :integer
#  character_length :integer
#  percent_of_total :float
#  percent_of_surah :float
#  surah_id         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  favorites_count  :integer          default(0)
#  memories_count   :integer          default(0)
#

require 'rails_helper'

RSpec.describe Quran::Ayah, type: :model do
  context 'associations' do
    it { is_expected.to belong_to :surah }
    it { is_expected.to have_many :texts }
    it { is_expected.to have_many :favorites }
    it { is_expected.to have_many :memories }
    it { is_expected.to have_many :comments }
    it do
      is_expected.to(
        have_many(:texts_and_included_translations).class_name('Quran::Text')
      )
    end
  end

  context 'instance methods' do
    let(:ayah) { Quran::Ayah.first }
    let(:commentable) { ayah }

    it_behaves_like 'commentable'

    describe '#noble_quran_text' do
      it 'is equal to the text content of the translation with an id of 3' do
        expect(ayah.noble_quran_text).to include 'In the Name of Allah'
      end
    end

    describe '#surah_name' do
      it 'is equal to surah.transliterated_name' do
        expect(ayah.surah_name).to eq 'Al-Fatihah'
      end
    end

    describe '#previous' do
      it 'returns the previous ayah' do
        expect(ayah.previous).to eq(Quran::Ayah.last)
      end
    end

    describe '#next' do
      it 'returns the next ayah' do
        expect(ayah.next).to eq(Quran::Ayah.second)
      end
    end
  end
end
