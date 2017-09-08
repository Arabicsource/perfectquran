# frozen_string_literal: true

require 'rails_helper'

describe 'Topic management', type: :request do
  let(:user) { FactoryGirl.create(:user, :confirmed) }
  let(:ayah) { FactoryGirl.create(:ayah) }
  let(:topic) { FactoryGirl.create(:topic) }
  let(:topic_attributes) { FactoryGirl.attributes_for(:topic) }
  let(:params) { { topic: topic_attributes, ayah_id: ayah.id } }

  describe 'page access' do
    describe 'GET topics#show' do
      context 'guest' do
        before { get topic_path(topic) }
        specify { expect(response).to be_successful }
      end
    end

    describe 'GET /topics/new' do
      context 'geust' do
        before { get new_ayah_topic_path(ayah) }
        specify { expect(response).to redirect_to new_user_session_path }
      end

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
      context 'guest' do
        before { post '/topics' }
        specify { expect(response).to redirect_to new_user_session_path }
      end
    end
  end

  describe 'POST topices#create' do
    before { login_as user }

    describe 'successful submission' do
      specify do
        expect { post '/topics', params: params }.to change(Topic, :count)
        expect(response)
          .to redirect_to ayah_by_number_path(ayah.surah.id, ayah.number)
      end
    end

    describe 'empty submission' do
      specify do
        empty_params = { topic: { subject: '', content: '' }, ayah_id: ayah.id }
        expect { post '/topics', params: empty_params }
          .not_to change(Topic, :count)
        expect(response.body).to include 'Subject can&#39;t be blank'
        expect(response.body).to include 'Content can&#39;t be blank'
      end
    end

    describe 'invalid subject' do
      specify 'too short' do
        params[:topic][:subject] = 'aa'
        expect { post '/topics', params: params }.not_to change(Topic, :count)
        expect(response.body).to include 'Subject is too short'
      end

      specify 'too long' do
        params[:topic][:subject] = 'a' * 101
        expect { post '/topics', params: params }.not_to change(Topic, :count)
        expect(response.body).to include 'Subject is too long'
      end
    end

    describe 'invalid content' do
      specify 'too short' do
        params[:topic][:content] = 'aa'
        expect { post '/topics', params: params }.not_to change(Topic, :count)
        expect(response.body).to include 'Content is too short'
      end
    end
  end
end
