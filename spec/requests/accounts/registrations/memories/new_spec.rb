# frozen_string_literal: true

require 'rails_helper'

describe 'GET /accounts/registrations/memory/new', type: :request do
  let(:url) { new_accounts_registrations_memory_path }
  let(:account) { create :account }

  it_behaves_like 'an account get request'
end
