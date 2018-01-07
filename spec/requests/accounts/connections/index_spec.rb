# frozen_string_literal: true

require 'rails_helper'

describe '/accounts/connections/index', type: :request do
  let(:url) { accounts_connections_path }
  let(:account) { create :account }
  let(:title) { 'Connections' }

  it_behaves_like 'an account get request'
end
