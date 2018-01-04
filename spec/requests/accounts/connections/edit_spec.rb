# frozen_string_literal: true

require 'rails_helper'

describe 'GET /accounts/profile/edit', type: :request do
  let(:connection) { create :connection, account: account }
  let(:url) { edit_accounts_connection_path(connection) }
  let(:account) { create :account }

  it_behaves_like 'an account get request'
end
