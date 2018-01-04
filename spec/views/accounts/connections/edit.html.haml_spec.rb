# frozen_string_literal: true

require 'rails_helper'

describe 'accounts/connections/edit' do
  let(:title) { 'Edit Connection' }

  before { assign :connection, build_stubbed(:connection) }

  it_behaves_like 'a titled view'
end
