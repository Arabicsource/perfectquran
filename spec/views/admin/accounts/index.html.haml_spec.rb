# frozen_string_literal: true

require 'rails_helper'

describe 'admin/accounts/index' do
  let(:title) { 'Accounts' }

  before { assign :accounts, [] }

  it_behaves_like 'a titled view'
end
