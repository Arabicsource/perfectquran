# frozen_string_literal: true

require 'rails_helper'

describe '/account/connections/edit', type: :request do
  fixtures :translations

  let(:connection) do
    create(
      :connection, account: account, translation: translations(:translation_1)
    )
  end
  let(:url) { edit_account_connection_path(connection) }
  let(:account) { create :account }
  let(:title) { 'Edit Connection' }

  it_behaves_like 'an account get request'

  context 'when account is not the resource owner' do
    before { login_as create :account }

    it 'raises exception' do
      expect { get url }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
