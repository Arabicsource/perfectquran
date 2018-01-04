# frozen_string_literal: true

require 'rails_helper'

describe 'accounts/connections/index' do
  let(:title) { 'Connections' }

  before { assign :connections, [] }

  it_behaves_like 'a titled view'
end
