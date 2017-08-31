require 'rails_helper'

describe 'Topic management', type: :request do

  let(:user) { FactoryGirl.create(:user) }
  let(:ayah) { FactoryGirl.create(:ayah) }

  describe 'page access' do

    describe 'GET /topics/new'

      # Guests should be redirected to the login page
      context 'geust' do
        before { get new_ayah_topic_path(ayah) }
        specify { expect(response).to redirect_to new_user_session_path }
      end

      # Users should be able to access the new topic page
      context 'user' do
        before do
          user.confirm
          login_as user
          get new_ayah_topic_path(ayah)
        end
        specify { expect(response).to be_successful }
        specify { expect(response.body).to include 'topic-form' }
      end
  end
end