# frozen_string_literal: true

RSpec.shared_examples 'an account get request' do
  context 'without account' do
    it 'redirects to the login page' do
      get url

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'with account' do
    before { login_as account }

    it 'responds successfully' do
      get url

      expect(response).to be_successful
    end
  end
end
