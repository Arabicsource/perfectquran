require 'rails_helper'

describe 'Registrations' do

  describe 'GET /register' do

    context 'geust' do
      before { get '/register' }
      specify { expect(response).to be_successful }
      specify { expect(response.body).to include 'registration-form' }
    end
  end

  describe 'POST /register' do

  end
end