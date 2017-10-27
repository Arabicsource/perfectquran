# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurahsHelper, type: :helper do
  let(:favorite) { FactoryBot.create(:favorite, ayah: Quran::Ayah.first) }

  describe '#ayah_is_favorited?' do
    specify do
      expect(ayah_is_favorited?(favorite.user, favorite.ayah)).to be_truthy
    end

    specify 'when user is nil the result is falsey' do
      expect(ayah_is_favorited?(nil, favorite.ayah)).to be_falsey
    end
  end

  describe '#ayah_is_memorized?' do
    let(:memory) { FactoryBot.create(:memory, ayah: Quran::Ayah.first) }

    specify do
      expect(helper.ayah_is_memorized?(memory.user, memory.ayah)).to be_truthy
    end

    specify 'when user is nil the result is falsey' do
      expect(helper.ayah_is_memorized?(nil, memory.ayah)).to be_falsey
    end
  end
end
