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
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe Quran::Surah, type: :model do
  subject { Quran::Surah.first }

  it { is_expected.to be_valid }
  it { is_expected.to have_many(:ayahs) }
  it do
    is_expected.to define_enum_for(:revelation_type).with(%i[meccan medinan])
  end
  it { is_expected.to have_many(:ayahs_and_included_texts).class_name('Ayah') }

  describe '#ayahs' do
    it 'returns ayahs in Ascending order' do
      expect(subject.ayahs.map(&:id)).to eq [1, 2, 3, 4, 5, 6, 7]
    end
  end

  describe '#next' do
    before { @surahs = Quran::Surah.all }
    specify 'returns the next surah' do
      first_surah = @surahs.first
      expect(first_surah.next).to eq(@surahs[1])
    end

    specify 'returns first surah if current surah is last' do
      expect(@surahs.last.next).to eq(@surahs[0])
    end
  end

  describe '#previous' do
    before { @surahs = Quran::Surah.all }

    specify 'returns the previous surah' do
      expect(@surahs.last.previous).to eq(@surahs[112])
    end

    specify 'returns the last surah if the current surah is first' do
      expect(@surahs.first.previous).to eq(@surahs.last)
    end
  end
end
