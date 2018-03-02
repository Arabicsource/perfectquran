# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Surahs API', type: :request do
  it 'gets a list of all surahs' do
    create_list :surah, 5

    get '/api/v1/surahs'

    expect(response).to be_successful
    expect(JSON.parse(response.body).length).to eq(5)
  end

  it 'gets a specific surah' do
    surah = create :surah, id: 1,
                           number_of_ayahs: 7,
                           order_of_revelation: 5,
                           revelation_type: 'meccan',
                           permalink: 'al-fatihah',
                           transliterated_name: 'Al-Fatihah',
                           arabic_name: 'arabic',
                           english_name: 'open',
                           character_length: 12

    get "/api/v1/surahs/#{surah.id}"
    json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(json['id']).to eq 1
    expect(json['number_of_ayahs']).to eq 7
    expect(json['order_of_revelation']).to eq 5
    expect(json['revelation_type']).to eq 'meccan'
    expect(json['permalink']).to eq 'al-fatihah'
    expect(json['transliterated_name']).to eq 'Al-Fatihah'
    expect(json['arabic_name']).to eq 'arabic'
    expect(json['english_name']).to eq 'open'
    expect(json['character_length']).to eq 12
  end
end
