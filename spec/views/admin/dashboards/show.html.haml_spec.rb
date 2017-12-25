# frozen_string_literal: true

require 'rails_helper'

describe 'admin/dashboards/show' do
  before do
    assign :accounts, []
    assign :comments, []
    assign :memories, []
  end
  include_examples 'admin view', 'Dashboard', 'admin/dashboards/show'
end
