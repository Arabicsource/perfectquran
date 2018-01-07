# frozen_string_literal: true

require 'rails_helper'

describe 'GET Admin::Accounts#show', type: :request do
  let(:admin) { create :admin_account }
  let(:url) { admin_account_path(account) }
  let(:account) { create :account }
  let(:title) { "Account: #{account.email}" }

  it_behaves_like 'an admin get request'
end
