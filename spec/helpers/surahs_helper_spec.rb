# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurahsHelper, type: :helper do
  let(:surah) { Quran::Surah.first }
  let(:bc) { helper.breadcrumb(surah) }
  let(:pnl) { helper.previous_next_links(surah) }
  let(:favorite) { FactoryGirl.create(:favorite, ayah: Ayah.first) }

  describe '#breadcrumb' do
    specify { expect(bc).to have_css 'div.breadcrumb' }
    specify { expect(bc).to have_link 'Home' }
    specify { expect(bc).to have_text surah.transliterated_name }
  end

  describe '#previous_next_links' do
    specify { expect(pnl).to have_link 'Previous' }
    specify { expect(pnl).to have_link 'Next' }
  end

  describe '#ayah_is_favorited?' do
    specify do
      expect(ayah_is_favorited?(favorite.user, favorite.ayah)).to be_truthy
    end

    specify 'when user is nil the result is falsey' do
      expect(ayah_is_favorited?(nil, favorite.ayah)).to be_falsey
    end
  end

  describe '#ayah_is_memorized?' do
    let(:memory) { FactoryGirl.create(:memory, ayah: Ayah.first) }

    specify do
      expect(helper.ayah_is_memorized?(memory.user, memory.ayah)).to be_truthy
    end

    specify 'when user is nil the result is falsey' do
      expect(helper.ayah_is_memorized?(nil, memory.ayah)).to be_falsey
    end
  end
end
