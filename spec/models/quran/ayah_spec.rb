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
#

require 'rails_helper'

RSpec.describe Quran::Ayah, type: :model do
  context 'associations' do
    it { is_expected.to belong_to :surah }
    it { is_expected.to have_many :texts }
    it do
      is_expected.to(
        have_many(:texts_and_included_translations).class_name('Quran::Text')
      )
    end
  end

  context 'instance methods' do
    describe '#noble_quran_text' do
      it 'is equal to the text content of the translation with an id of 3' do
        ayah = create :ayah
        translation = create :translation, id: 3
        create :text, ayah: ayah, translation: translation, content: 'abc123'

        expect(ayah.noble_quran_text).to eq 'abc123'
      end
    end

    describe '#surah_name' do
      it 'is equal to surah.transliterated_name' do
        surah = build_stubbed :surah, transliterated_name: 'abc123'
        ayah = build_stubbed :ayah, surah: surah

        expect(ayah.surah_name).to eq 'abc123'
      end
    end

    describe '#previous?' do
      it 'returns truthy if previous ayah is found' do
        create :ayah, id: 1
        ayah = create :ayah, id: 2

        expect(ayah.previous?).to be_truthy
      end

      it 'returns falsely if previous is not found' do
        ayah = create :ayah

        expect(ayah.previous?).to be_falsey
      end
    end

    describe '#previous' do
      it 'returns the previous ayah' do
        first = create :ayah, id: 1
        second = create :ayah, id: 2

        expect(second.previous).to eq(first)
      end

      it 'returns nil if ayah id is not found' do
        ayah = create :ayah

        expect(ayah.previous).to be_nil
      end
    end

    describe '#next?' do
      it 'returns truthy if next ayah is found' do
        ayah = create :ayah, id: 1
        create :ayah, id: 2

        expect(ayah.next?).to be_truthy
      end

      it 'returns falsly if next is not found' do
        ayah = create :ayah

        expect(ayah.next?).to be_falsey
      end
    end

    describe '#next' do
      it 'returns the next ayah' do
        first = create :ayah, id: 1
        second = create :ayah, id: 2

        expect(first.next).to eq(second)
      end

      it 'returns nil if ayah id is not found' do
        ayah = create :ayah

        expect(ayah.next).to be_nil
      end
    end
  end
end
