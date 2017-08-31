require 'rails_helper'

describe 'Topic management', type: :request do

  let(:user) { FactoryGirl.create(:user) }
  let(:ayah) { FactoryGirl.create(:ayah) }
  let(:topic) { FactoryGirl.create(:topic) }
  let(:topic_attributes) { FactoryGirl.attributes_for(:topic) }

  describe 'page access' do

    describe 'GET topics#show' do
      
      # Guests should have access
      context 'guest' do
        before { get topic_path(topic) }
        specify { expect(response).to be_successful }
      end
    end

    describe 'GET /topics/new' do

      # Guests should be redirected to the login page
      context 'geust' do
        before { get new_ayah_topic_path(ayah) }
        specify { expect(response).to redirect_to new_user_session_path }
      end

      # Users should be able to access the new topic page
      context 'user' do
        before do
          login_as user
          get new_ayah_topic_path(ayah)
        end
        specify { expect(response).to be_successful }
        specify { expect(response.body).to include 'topic-form' }
      end
    end

    describe 'POST topics#create' do
      
      # Guests should be redireted to the login page
      context 'guest' do
        before { post "/topics" }
        specify { expect(response).to redirect_to new_user_session_path }
      end
    end
  end
end