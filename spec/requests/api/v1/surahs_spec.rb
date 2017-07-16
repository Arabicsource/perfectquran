require "rails_helper"

RSpec.describe "Surahs API", type: :request do

  it "gets a list of all surahs" do
    # Given we have a list of surahs
    FactoryGirl.create_list(:surah, 10)
    # When I visit surahs api 
    get '/api/v1/surahs'
    # Then I expect a successful response
    expect(response).to be_success
    # And the number of surahs returned is equal to the number of surahs in the database
    expect(JSON.parse(response.body).length).to eq(10)
  end

  it "gets a specific surah" do
    # Given there is a surah
    surah = FactoryGirl.create(:surah)
    # When I visit that  surah's api endpoint
    get "/api/v1/surahs/#{surah.id}"
    json = JSON.parse(response.body)
    # Then I expect the response to be successful
    expect(response).to be_success
    # And that the response body equals the surah
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