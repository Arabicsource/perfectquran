# How to stub an active record set

# frozen_string_literal: true

# == Schema Information
#
# Table name: quran_ayahs
#
#  id               :integer          not null, primary key
#  number           :integer
#  character_length :integer
#  percent_of_total :float
#  percent_of_surah :float
#  surah_id         :integer
#

require 'rails_helper'

RSpec.describe Quran::Ayah, type: :model do
  it { is_expected.to belong_to :surah }
  it { is_expected.to have_many :texts }
  it { is_expected.to have_many :memories }
  it { is_expected.to have_many(:tags).through(:taggings) }

  it do
    is_expected.to(
      have_many(:texts_and_included_translations).class_name('Quran::Text')
    )
  end

  describe '.noble_quran_text' do
    before do
      @ayah = create :ayah
      translation = create :translation, id: 3
      create :text, translation: translation, ayah: @ayah, content: 'abc123'
    end

    specify { expect(@ayah.noble_quran_text).to eq 'abc123' }
  end

  describe '.surah_name' do
    before do
      surah = build_stubbed :surah, transliterated_name: 'abc123'
      @ayah = build_stubbed :ayah, surah: surah
    end

    specify { expect(@ayah.surah_name).to eq 'abc123' }
  end

  describe '.previous' do
    before do
      @first = create :ayah, id: 1
      @second = create :ayah, id: 2
      @last = create :ayah, id: 6236
    end

    specify { expect(@second.previous).to eq(@first) }
    specify { expect(@first.previous).to eq(@last) }
  end

  describe '.next' do
    before do
      @first = create :ayah, id: 1
      @second = create :ayah, id: 2
      @last = create :ayah, id: 6236
    end

    specify { expect(@first.next).to eq(@second) }
    specify { expect(@last.next).to eq(@first) }
  end
end
