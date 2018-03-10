# frozen_string_literal: true

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
