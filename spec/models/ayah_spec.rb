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

RSpec.describe Ayah, type: :model do
  let(:ayahs) { Ayah.all }
  subject { Ayah.first }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to :surah }
  it { is_expected.to have_many :texts }
  it { is_expected.to have_many :favorites }
  it { is_expected.to have_many :memories }
  it { is_expected.to have_many :comments }
  it do
    is_expected.to have_many(:texts_and_included_translations).class_name 'Text'
  end

  it_behaves_like 'commentable'

  describe '#noble_quran_text' do
    it 'is equal to the text content of the translation with an id of 3' do
      expect(subject.noble_quran_text).to include 'In the Name of Allah'
    end
  end

  describe '#surah_name' do
    it 'is equal to surah.transliterated_name' do
      expect(subject.surah_name).to eq 'Al-Fatihah'
    end
  end

  describe '#previous' do
    it 'returns the previous ayah' do
      expect(ayahs.second.previous).to eq(ayahs.first)
    end
  end

  describe '#next' do
    it 'returns the next ayah' do
      expect(ayahs.second.next).to eq(ayahs.third)
    end
  end
end
