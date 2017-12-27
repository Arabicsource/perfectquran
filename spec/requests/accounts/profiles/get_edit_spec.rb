# frozen_string_literal: true

require 'rails_helper'

describe 'GET /accounts/profile/edit', type: :request do
  let(:url) { edit_accounts_profile_path }
  let(:account) { create :account }

  it_behaves_like 'an account get request'

  context 'without a profile' do
    let(:account) { create :account }

    before { login_as account }

    it 'creates a profile' do
      expect { get url }.to change(Profile, :count).by(1)
    end
  end
end
