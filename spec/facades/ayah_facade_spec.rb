# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AyahFacade, type: :model do
  let(:ayah) { FactoryGirl.create(:ayah) }
  let(:user) { FactoryGirl.create(:user) }
  let(:ayah_facade) { AyahFacade.new(ayah.surah.id, ayah.number, user) }

  specify { expect(ayah_facade).to respond_to :surah_name }
  specify do
    expect(ayah_facade.surah_name).to eq ayah.surah.transliterated_name
  end

  specify { expect(ayah_facade).to respond_to :surah_permalink }
  specify { expect(ayah_facade.surah_permalink).to eq ayah.surah.permalink }

  specify { expect(ayah_facade).to respond_to :number }
  specify { expect(ayah_facade.number).to eq ayah.number }

  specify { expect(ayah_facade).to respond_to :previous? }
  specify { expect(ayah_facade.previous?).to eq ayah.previous? }

  specify { expect(ayah_facade).to respond_to :next? }
  specify { expect(ayah_facade.next?).to eq ayah.next? }

  specify { expect(ayah_facade).to respond_to :texts }
  specify { expect(ayah_facade.texts).to eq ayah.texts.ordered_by_quran_id }
end
