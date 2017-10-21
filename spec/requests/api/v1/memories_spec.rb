# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Memories API', type: :request do
  let(:user) { FactoryGirl.create :user, :confirmed }

  describe 'GET /api/v1/ayahs/:ayah_id/memories' do
    before do
      ayah = Ayah.first
      FactoryGirl.create_list(:memory, 3, ayah: ayah)
      sign_in user
      get "/api/v1/ayahs/#{ayah.id}/memories"
    end

    it 'returns a success response' do
      expect(response).to be_success
    end

    it 'returns 3 memories' do
      memories = JSON.parse(response.body)
      expect(memories.size).to eq 3
    end
  end

  describe 'POST /api/v1/ayahs/:ayah_id/memories' do
    context 'guest' do
      it 'returns an unauthorized response' do
        ayah = Ayah.first
        post "/api/v1/ayahs/#{ayah.id}/memories"
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'registered user' do
      before do
        @ayah = Ayah.first
        sign_in user
      end

      it 'returns a success response' do
        post "/api/v1/ayahs/#{@ayah.id}/memories"
        expect(response).to be_success
      end

      it 'returns a memory' do
        post "/api/v1/ayahs/#{@ayah.id}/memories"
        memory = Memory.find_by(user_id: user.id, ayah_id: @ayah.id)
        json = JSON.parse(response.body)
        expect(json['id']).to eq(memory.id)
        expect(json['user_id']).to eq(memory.user_id)
        expect(json['ayah_id']).to eq(memory.ayah_id)
      end
    end
  end

  describe 'DELETE /api/v1/ayahs/:ayah_id/memories/:id' do
    before do
      @ayah = Ayah.first
      @memory = FactoryGirl.create(:memory, ayah: @ayah, user: user)
      sign_in user
    end

    it 'returns a success response' do
      delete "/api/v1/ayahs/#{@memory.ayah.id}/memories/#{@memory.id}"
      expect(response).to be_success
    end

    it 'returns a success message' do
      delete "/api/v1/ayahs/#{@memory.ayah.id}/memories/#{@memory.id}"
      expect(JSON.parse(response.body)['message'])
        .to eq('Successfully Deleted')
    end
  end
end
