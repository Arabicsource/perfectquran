# frozen_string_literal: true

RSpec.shared_examples 'an account get request' do
  context 'without account' do
    it 'redirects to the login page' do
      get url

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'with account' do
    context 'when application' do
      before do
        login_as account
        get url
      end

      specify { expect(response).to be_successful }
    end
  end
end
