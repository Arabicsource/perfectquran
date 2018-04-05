# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pageable do
  let(:juz_1) { Quran::Juz.first }
  let(:page_1) { Quran::Page.first }
  let(:surah_1) { Quran::Surah.first }

  describe 'pages' do
    specify { expect(surah_1.pages.map(&:id)).to eq [1] }
    specify { expect(juz_1.pages.map(&:id)).to eq (1..21).to_a }
  end

  describe 'first_page' do
    specify { expect(surah_1.first_page).to eq page_1 }
    specify { expect(juz_1.first_page).to eq page_1 }
  end
end
