# frozen_string_literal: true

RSpec.shared_examples 'an account post request' do
  context 'without account' do
    it 'redirects to the login page' do
      post url, params: valid_params

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'with account' do
    before { login_as account }

    context 'when success' do
      it 'redirects' do
        post url, params: valid_params

        expect(response).to redirect_to redirect_path
      end

      it 'creates' do
        expect { post url, params: valid_params }.to change(klass, :count).by(1)
      end
    end

    context 'when error' do
      it 'does not redirect' do
        post url, params: invalid_params

        expect(response).not_to redirect_to redirect_path
      end

      it 'does not create' do
        expect { post url, params: invalid_params }.not_to change(klass, :count)
      end
    end
  end
end
