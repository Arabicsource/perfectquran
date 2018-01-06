# frozen_string_literal: true

require 'rails_helper'

describe 'admin/accounts/show' do
  let(:account) { build_stubbed :account }
  let(:title) { "Account: #{account.email}" }

  before { assign :account, account }

  it_behaves_like 'a titled view'
end
