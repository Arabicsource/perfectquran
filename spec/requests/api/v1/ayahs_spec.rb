# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Ayahs API', type: :request do
  describe 'GET /api/v1/ayahs' do
    it 'returns a success response' do
      get '/api/v1/ayahs'
      expect(response).to be_success
    end

    it 'returns all ayahs' do
      create_list :ayah, 5

      get '/api/v1/ayahs'

      expect(JSON.parse(response.body).length).to eq(5)
    end
  end

  describe 'GET /api/v1/ayahs/:ayah_id' do
    before { @ayah = create :ayah }

    it 'returns a success response' do
      get "/api/v1/ayahs/#{@ayah.id}"
      expect(response).to be_success
    end

    it 'returns a specific ayah' do
      get "/api/v1/ayahs/#{@ayah.id}"
      json = JSON.parse(response.body)
      expect(json['id']).to eq(@ayah.id)
      expect(json['number']).to eq(@ayah.number)
      expect(json['character_length']).to eq(@ayah.character_length)
      expect(json['percent_of_total']).to eq(@ayah.percent_of_total)
      expect(json['percent_of_surah']).to eq(@ayah.percent_of_surah)
      expect(json['surah_id']).to eq(@ayah.surah_id)
    end
  end

  describe 'GET /api/v1/surah/:surah_id/ayah/:ayah_number' do
    before { @ayah = create :ayah }

    it 'returns a success response' do
      get "/api/v1/surah/#{@ayah.surah.id}/ayah/#{@ayah.number}"
      expect(response).to be_success
    end

    it 'returns a specific ayah' do
      get "/api/v1/surah/#{@ayah.surah.id}/ayah/#{@ayah.number}"
      json = JSON.parse(response.body)
      expect(json['id']).to eq(@ayah.id)
      expect(json['number']).to eq(@ayah.number)
      expect(json['character_length']).to eq(@ayah.character_length)
      expect(json['percent_of_total']).to eq(@ayah.percent_of_total)
      expect(json['percent_of_surah']).to eq(@ayah.percent_of_surah)
      expect(json['surah_id']).to eq(@ayah.surah_id)
    end
  end
end
