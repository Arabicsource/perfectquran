# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Favorites API', type: :request do
  let(:user) { FactoryGirl.create(:user, :confirmed) }

  describe 'POST /api/v1/ayahs/:ayah_id/favorites' do
    before do
      @ayah = Ayah.first
      sign_in user
    end

    it 'returns a success response' do
      post "/api/v1/ayahs/#{@ayah.id}/favorites"
      expect(response).to be_success
    end

    it 'returns a favorite' do
      post "/api/v1/ayahs/#{@ayah.id}/favorites"
      favorite = Favorite.find_by(user_id: user.id, ayah_id: @ayah.id)
      json = JSON.parse(response.body)
      expect(json['id']).to eq(favorite.id)
      expect(json['user_id']).to eq(favorite.user_id)
      expect(json['ayah_id']).to eq(favorite.ayah_id)
    end
  end

  describe 'DELETE /api/v1/ayahs/:ayah_id/favorites' do
    before do
      @ayah = Ayah.first
      @favorite = FactoryGirl.create(:favorite, ayah: @ayah, user: user)
      sign_in user
    end

    it 'returns a success response' do
      delete "/api/v1/ayahs/#{@ayah.id}/favorites/#{@favorite.id}"
      expect(response).to be_success
    end

    it 'returns a success message' do
      delete "/api/v1/ayahs/#{@ayah.id}/favorites/#{@favorite.id}"
      expect(JSON.parse(response.body)['message'])
        .to eq('Successfully Deleted')
    end
  end
end
