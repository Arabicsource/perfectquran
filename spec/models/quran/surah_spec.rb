# frozen_string_literal: true

# == Schema Information
#
# Table name: surahs
#
#  id                  :bigint(8)        not null, primary key
#  number_of_ayahs     :integer
#  order_of_revelation :integer
#  revelation_type     :integer
#  permalink           :string
#  transliterated_name :string
#  arabic_name         :string
#  english_name        :string
#  character_length    :integer
#

require 'rails_helper'

RSpec.describe Quran::Surah, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:ayahs) }

    it do
      is_expected.to have_many(:ayahs_and_included_texts).class_name('Ayah')
    end
  end

  describe 'enums' do
    it do
      is_expected.to define_enum_for(:revelation_type).with(%i[meccan medinan])
    end
  end

  describe 'next' do
    specify { expect(Quran::Surah.second.next).to eq Quran::Surah.third }
    specify { expect(Quran::Surah.last.next).to eq(Quran::Surah.first) }
  end

  describe 'previous' do
    specify { expect(Quran::Surah.third.previous).to eq Quran::Surah.second }
    specify { expect(Quran::Surah.first.previous).to eq(Quran::Surah.last) }
  end

  specify 'description' do
    expect(Quran::Surah.first.description).to eq 'The Opening - الفاتحة'
  end

  specify 'to_s' do
    expect(Quran::Surah.first.to_s).to eq 'Al-Fatihah'
  end
end
