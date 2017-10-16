# frozen_string_literal: true

require 'rails_helper'

describe 'Ayahs' do
  let(:ayah) { FactoryGirl.create(:ayah) }

  describe 'GET ayah_by_number_path' do
    before { get ayah_by_number_path(ayah.surah.id, ayah.number) }
    specify { expect(response).to be_successful }
  end
end
