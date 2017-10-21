# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Surahs API', type: :request do
  it 'gets a list of all surahs' do
    get '/api/v1/surahs'
    expect(response).to be_success
    expect(JSON.parse(response.body).length).to eq(114)
  end

  it 'gets a specific surah' do
    surah = Surah.first
    get "/api/v1/surahs/#{surah.id}"
    json = JSON.parse(response.body)
    expect(response).to be_success
    expect(json['id']).to eq 1
    expect(json['number_of_ayahs']).to eq 7
    expect(json['order_of_revelation']).to eq 5
    expect(json['revelation_type']).to eq 'meccan'
    expect(json['permalink']).to eq 'al-fatihah'
    expect(json['transliterated_name']).to eq 'Al-Fatihah'
    expect(json['arabic_name']).to eq(surah.arabic_name)
    expect(json['english_name']).to eq(surah.english_name)
    expect(json['character_length']).to eq(surah.character_length)
    expect(json['percent_of_total']).to eq(surah.percent_of_total)
  end
end
