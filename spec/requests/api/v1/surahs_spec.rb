# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Surahs API', type: :request do
  it 'gets a list of all surahs' do
    get '/api/v1/surahs'

    expect(response).to be_successful
    expect(JSON.parse(response.body).length).to eq(114)
  end

  it 'gets a specific surah' do
    get "/api/v1/surahs/1"
    json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(json['id']).to eq 1
    expect(json['number_of_ayahs']).to eq 7
    expect(json['order_of_revelation']).to eq 5
    expect(json['revelation_type']).to eq 'meccan'
    expect(json['permalink']).to eq 'al-fatihah'
    expect(json['transliterated_name']).to eq 'Al-Fatihah'
  end
end
