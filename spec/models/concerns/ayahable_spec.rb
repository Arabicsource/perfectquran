# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ayahable do
  let(:ayah_1) { Quran::Ayah.first }
  let(:ayah_2) { Quran::Ayah.second }
  let(:ayah_7) { Quran::Ayah.find(7) }
  let(:ayah_8) { Quran::Ayah.find(8) }
  let(:ayah_12) { Quran::Ayah.find(12) }
  let(:ayah_148) { Quran::Ayah.find(148) }
  let(:ayah_149) { Quran::Ayah.find(149) }
  let(:ayah_259) { Quran::Ayah.find(259) }
  let(:ayah_293) { Quran::Ayah.find(293) }
  let(:juz_1) { Quran::Juz.first }
  let(:juz_2) { Quran::Juz.second }
  let(:page_1) { Quran::Page.first }
  let(:page_2) { Quran::Page.second }
  let(:surah_1) { Quran::Surah.first }
  let(:surah_2) { Quran::Surah.second }

  describe 'ayahs' do
    specify { expect(page_1.ayahs.map(&:id)).to eq((1..7).to_a) }
    specify { expect(surah_1.ayahs.map(&:id)).to eq((1..7).to_a) }
    specify { expect(juz_1.ayahs.map(&:id)).to eq((1..148).to_a) }
  end

  describe 'first_ayah' do
    specify { expect(page_1.first_ayah).to eq ayah_1 }
    specify { expect(page_2.first_ayah).to eq ayah_8 }
    specify { expect(surah_1.first_ayah).to eq ayah_1 }
    specify { expect(surah_2.first_ayah).to eq ayah_8 }
    specify { expect(juz_1.first_ayah).to eq ayah_1 }
    specify { expect(juz_2.first_ayah).to eq ayah_149 }
  end

  describe 'current_ayah' do
    specify { expect(page_1.current_ayah).to eq ayah_1 }

    context 'when set to another ayah' do
      before { page_1.current_ayah = ayah_2 }

      specify { expect(page_1.current_ayah).to eq ayah_2 }
    end

    context 'when set to an ayah outside scope' do
      before { page_1.current_ayah = ayah_8 }

      specify { expect(page_1.current_ayah).to eq ayah_1 }
    end
  end

  describe 'current_ayah?' do
    specify { expect(page_1.current_ayah?(ayah_1)).to be true }
    specify { expect(page_1.current_ayah?(ayah_2)).to be false }

    context 'when current_ayah is set to another ayah' do
      before { page_1.current_ayah = ayah_2 }

      specify { expect(page_1.current_ayah?(ayah_1)).to be false }
      specify { expect(page_1.current_ayah?(ayah_2)).to be true }
    end
  end

  describe 'previous_ayah' do
    specify { expect(page_1.previous_ayah).to eq ayah_7 }

    context 'when current_ayah is set to another ayah' do
      before { page_1.current_ayah = ayah_2 }

      specify { expect(page_1.previous_ayah).to eq ayah_1 }
    end
  end

  describe 'previous_ayah?' do
    specify { expect(page_1.previous_ayah?).to be false }

    context 'when current_ayah is set to another ayah' do
      before { page_1.current_ayah = ayah_2 }

      specify { expect(page_1.previous_ayah?).to be true }
    end
  end

  describe 'last_ayah' do
    specify { expect(page_1.last_ayah).to eq ayah_7 }
    specify { expect(page_2.last_ayah).to eq ayah_12 }
    specify { expect(surah_1.last_ayah).to eq ayah_7 }
    specify { expect(surah_2.last_ayah).to eq ayah_293 }
    specify { expect(juz_1.last_ayah).to eq ayah_148 }
    specify { expect(juz_2.last_ayah).to eq ayah_259 }
  end

  describe 'next_ayah' do
    specify { expect(page_1.next_ayah).to eq ayah_2 }

    context 'when current_ayah is set to another ayah' do
      before { page_1.current_ayah = ayah_7 }

      specify { expect(page_1.next_ayah).to eq ayah_1 }
    end
  end

  describe 'next_ayah?' do
    specify { expect(page_1.next_ayah?).to be true }

    context 'when current_ayah is set to another ayah' do
      before { page_1.current_ayah = ayah_7 }

      specify { expect(page_1.next_ayah?).to be false }
    end
  end
end
