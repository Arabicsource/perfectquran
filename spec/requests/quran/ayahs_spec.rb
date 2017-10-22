# frozen_string_literal: true

require 'rails_helper'

describe 'Ayahs', type: :request do
  context 'GET show' do
    it 'responds successfully' do
      ayah = Ayah.first

      get quran_ayah_path(ayah)

      expect(response).to be_successful
    end
  end

  context 'GET /:surah_id/:ayah_number' do
    it 'responds successfully' do
      ayah = Ayah.first

      get "/#{ayah.surah.id}/#{ayah.number}"

      expect(response).to be_successful
    end

    it 'renders quran/surahs/show' do
      ayah = Ayah.first

      get "/#{ayah.surah.id}/#{ayah.number}"

      expect(response).to render_template 'quran/ayahs/show'
    end
  end
end
