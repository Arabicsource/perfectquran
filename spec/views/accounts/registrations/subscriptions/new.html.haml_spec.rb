# frozen_string_literal: true

require 'rails_helper'

describe 'accounts/registrations/subscriptions/new' do
  let(:title) { 'Subscribe to PerfectQuran' }

  it_behaves_like 'a titled view'
end
