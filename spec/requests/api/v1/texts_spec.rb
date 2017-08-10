require "rails_helper"

RSpec.describe "Texts API", type: :request do

  describe "/text/ayah/:ayah_id/quran/:quran_id" do
    before { @text = FactoryGirl.create(:text) }

    it "returns a success response" do
        get "/api/v1/text/ayah/#{@text.ayah_id}/quran/#{@text.quran_id}"
        expect(response).to be_success
    end

    it "returns a specific text" do
        get "/api/v1/text/ayah/#{@text.ayah_id}/quran/#{@text.quran_id}"
        json = JSON.parse(response.body)
        expect(json['id']).to eq(@text.id)
        expect(json['content']).to eq(@text.content)
        expect(json['ayah_id']).to eq(@text.ayah_id)
        expect(json['quran_id']).to eq(@text.quran_id)
    end
  end
end