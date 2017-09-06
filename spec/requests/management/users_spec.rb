require 'rails_helper'

describe 'User management', type: :request do

  describe 'GET #index' do

    context 'guest' do
      before { get manage_users_path }
      specify { expect(response).to redirect_to new_user_session_path }
    end
  end
end