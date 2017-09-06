require 'rails_helper'

describe 'Comment management', type: :request do

  let(:user) { FactoryGirl.create(:user, :confirmed) }
  let(:topic) { FactoryGirl.create(:topic) }
  let(:comment_attributes) { FactoryGirl.attributes_for(:comment) }
  let(:params) { { comment: comment_attributes } }

  describe 'page access' do

    describe 'POST comments#create' do
      
      # Guests should be redireted to the login page
      context 'guest' do
        before { post "/topics/#{topic.id}/comments", { params: params } }
        specify { expect(response).to redirect_to new_user_session_path }
      end
    end
  end

  describe 'POST comments#create' do

    before { login_as user }

    describe 'successful submission' do
      specify do
        expect { post "/topics/#{topic.id}/comments", { params: params } }.to change(Comment, :count)
        expect(response).to redirect_to topic_path(topic)
      end
    end

    describe 'empty submission' do
      specify do
        empty_params  = { comment: {content: ''} } 
        expect { post "/topics/#{topic.id}/comments", { params: empty_params } }.not_to change(Comment, :count)
        expect(response.body).to include 'Content can&#39;t be blank'
      end
    end

    describe 'invalid content' do
      specify 'too short' do
        params[:comment][:content] = 'aa'
        expect { post "/topics/#{topic.id}/comments", { params: params } }.not_to change(Comment, :count)        
        expect(response.body).to include 'Content is too short'
      end
    end
  end
end