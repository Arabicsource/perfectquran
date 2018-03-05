# frozen_string_literal: true

require 'rails_helper'
# require "browser/rails"

describe 'Ayahs', type: :request do
  let!(:ayah) { Ayah.second }

  describe 'GET quran_ayah_path(ayah)' do
    context 'when application' do
      before { get quran_ayah_path(ayah) }

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET /:surah_id/:ayah_number' do
    before { get "/#{ayah.surah.id}/#{ayah.number}" }

    specify { expect(response).to be_successful }
  end
end
