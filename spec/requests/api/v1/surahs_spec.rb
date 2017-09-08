# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Surahs API', type: :request do
  it 'gets a list of all surahs' do
    FactoryGirl.create_list(:surah, 10)
    get '/api/v1/surahs'
    expect(response).to be_success
    expect(JSON.parse(response.body).length).to eq(10)
  end

  it 'gets a specific surah' do
    surah = FactoryGirl.create(:surah)
    get "/api/v1/surahs/#{surah.id}"
    json = JSON.parse(response.body)
    expect(response).to be_success
    expect(json['id']).to eq(surah.id)
    expect(json['number_of_ayahs']).to eq(surah.number_of_ayahs)
    expect(json['order_of_revelation']).to eq(surah.order_of_revelation)
    expect(json['revelation_type']).to eq(surah.revelation_type)
    expect(json['permalink']).to eq(surah.permalink)
    expect(json['transliterated_name']).to eq(surah.transliterated_name)
    expect(json['arabic_name']).to eq(surah.arabic_name)
    expect(json['english_name']).to eq(surah.english_name)
    expect(json['character_length']).to eq(surah.character_length)
    expect(json['percent_of_total']).to eq(surah.percent_of_total)
  end
end
