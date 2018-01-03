# frozen_string_literal: true

require 'rails_helper'

describe 'accounts/subscriptions/show' do
  let(:title) { 'Subscription' }

  before do
    assign :subscription, build_stubbed(:subscription)
    assign :charge, build_stubbed(:charge)
  end

  it_behaves_like 'a titled view'
end
