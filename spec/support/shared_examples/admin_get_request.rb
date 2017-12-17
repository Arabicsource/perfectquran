# frozen_string_literal: true

RSpec.shared_examples 'admin get request' do |url|
  context 'guest' do
    it 'redirects the user to the login page' do
      get url

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'member' do
    it 'redirects the user to the root page' do
      login_as create :member
      get url

      expect(response).to redirect_to root_path
    end
  end

  context 'admin' do
    it 'responds successfully' do
      login_as create :admin
      get url

      expect(response).to be_successful
    end
  end
end
