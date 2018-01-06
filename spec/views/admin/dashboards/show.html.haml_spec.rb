# frozen_string_literal: true

require 'rails_helper'

describe 'admin/dashboards/show' do
  let(:title) { 'Dashboard' }

  before do
    assign :accounts, []
    assign :comments, []
    assign :memories, []
    assign :connections, []
  end

  it_behaves_like 'a titled view'
end
