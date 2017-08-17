require "rails_helper"


RSpec.describe "Memories API", type: :request do

  describe "POST /api/v1/ayahs/:ayah_id/memories" do
    before do
        @ayah = FactoryGirl.create(:ayah)
        @user = FactoryGirl.create(:user)
        @user.confirm
        sign_in @user
    end

    it "returns a success response" do
        post "/api/v1/ayahs/#{@ayah.id}/memories"
        expect(response).to be_success
    end

    it "returns a memory" do
        post "/api/v1/ayahs/#{@ayah.id}/memories"
        memory = Memory.find_by(user_id: @user.id, ayah_id: @ayah.id)
        json = JSON.parse(response.body); 
        expect(json['id']).to eq(memory.id)
        expect(json['user_id']).to eq(memory.user_id)
        expect(json['ayah_id']).to eq(memory.ayah_id)
    end
  end

  describe "DELETE /api/v1/ayahs/:ayah_id/memories/:id" do
    before do
        @memory = FactoryGirl.create(:memory)
        @user = @memory.user
        @user.confirm
        sign_in @user
    end

    it "returns a success response" do
        delete "/api/v1/ayahs/#{@memory.ayah.id}/memories/#{@memory.id}"
        expect(response).to be_success
    end

    it "returns a success message" do
        delete "/api/v1/ayahs/#{@memory.ayah.id}/memories/#{@memory.id}"
        expect(JSON.parse(response.body)["message"]).to eq("Successfully Deleted")
    end
  end
end