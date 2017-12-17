# frozen_string_literal: true

# == Schema Information
#
# Table name: surahs
#
#  id                  :integer          not null, primary key
#  number_of_ayahs     :integer
#  order_of_revelation :integer
#  revelation_type     :integer
#  permalink           :string
#  transliterated_name :string
#  arabic_name         :string
#  english_name        :string
#  character_length    :integer
#  percent_of_total    :float
#

require 'rails_helper'

RSpec.describe Quran::Surah, type: :model do
  it { is_expected.to have_many(:ayahs) }
  it do
    is_expected.to define_enum_for(:revelation_type).with(%i[meccan medinan])
  end
  it { is_expected.to have_many(:ayahs_and_included_texts).class_name('Ayah') }

  describe '#ayahs' do
    it 'returns ayahs in Ascending order' do
      surah = create :surah
      create(:ayah, id: 3, surah: surah)
      create(:ayah, id: 1, surah: surah)
      create(:ayah, id: 2, surah: surah)

      expect(surah.ayahs.map(&:id)).to eq [1, 2, 3]
    end
  end

  describe '#next' do
    before do
      @first = create :surah, id: 1
      @second = create :surah, id: 2
      @third = create :surah, id: 3
    end

    specify 'returns the next surah' do
      expect(@second.next).to eq(@third)
    end

    specify 'returns first surah if current surah is last' do
      expect(@third.next).to eq(@first)
    end
  end

  describe '#previous' do
    before do
      @first = create :surah, id: 1
      @second = create :surah, id: 2
      @third = create :surah, id: 3
    end

    specify 'returns the previous surah' do
      expect(@third.previous).to eq(@second)
    end

    specify 'returns the last surah if the current surah is first' do
      expect(@first.previous).to eq(@third)
    end
  end
end
