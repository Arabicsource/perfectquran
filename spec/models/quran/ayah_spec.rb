# How to stub an active record set

require 'rails_helper'

RSpec.describe Ayah, type: :model do
  it { is_expected.to belong_to :surah }
  it { is_expected.to have_many :texts }
  it { is_expected.to have_many :memories }
  it { is_expected.to have_many(:tags).through(:taggings) }

  it do
    is_expected.to(
      have_many(:texts_and_included_translations)
    )
  end

  describe '.noble_quran_text' do
    specify { expect(Ayah.first.noble_quran_text).to eq 'Noble Quran 1' }
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
      @first = Ayah.first
      @second = Ayah.second
      @last = Ayah.last
    end

    specify { expect(@second.previous).to eq(@first) }
    specify { expect(@first.previous).to eq(@last) }
  end

  describe '.next' do
    before do
      @first = Ayah.first
      @second = Ayah.second
      @last = Ayah.last
    end

    specify { expect(@first.next).to eq(@second) }
    specify { expect(@last.next).to eq(@first) }
  end
end
