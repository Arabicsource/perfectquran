# frozen_string_literal: true

# == Schema Information
#
# Table name: quran_surahs
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

RSpec.describe Surah, type: :model do
  context 'associations' do
    it { is_expected.to have_many(:memories).through(:ayahs) }
  end

  it { is_expected.to have_many(:ayahs) }
  it do
    is_expected.to define_enum_for(:revelation_type).with(%i[meccan medinan])
  end
  it { is_expected.to have_many(:ayahs_and_included_texts).class_name('Ayah') }

  describe '#ayahs' do
    it 'returns ayahs in Ascending order' do
      surah = Surah.first

      expect(surah.ayahs.map(&:id)).to eq [1, 2, 3, 4, 5, 6, 7]
    end
  end

  describe '#next' do
    before do
      @first = Surah.first
      @second = Surah.second
      @third = Surah.third
    end

    specify 'returns the next surah' do
      expect(@second.next).to eq(@third)
    end

    specify 'returns first surah if current surah is last' do
      expect(Surah.last.next).to eq(@first)
    end
  end

  describe '#previous' do
    before do
      @first = Surah.first
      @second = Surah.second
      @third = Surah.third
    end

    specify 'returns the previous surah' do
      expect(@third.previous).to eq(@second)
    end

    specify 'returns the last surah if the current surah is first' do
      expect(@first.previous).to eq(Surah.last)
    end
  end
end
