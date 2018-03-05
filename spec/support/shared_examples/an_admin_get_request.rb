# frozen_string_literal: true

RSpec.shared_examples 'an admin get request' do
  context 'without account' do
    it 'redirects to the login page' do
      get url

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'with account' do
    before { login_as account }

    it 'redirects to the root page' do
      get url

      expect(response).to redirect_to root_path
    end
  end

  context 'with admin account' do
    before do
      login_as admin
      get url
    end

    specify { expect(response).to be_successful }
  end
end
