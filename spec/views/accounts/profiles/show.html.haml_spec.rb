# frozen_string_literal: true

require 'rails_helper'

describe 'accounts/profiles/show' do
  let(:title) { 'Profile' }
  let(:profile) { build_stubbed :profile }
  let(:account) { build_stubbed :account }

  before do
    allow(view).to receive(:current_account).and_return(account)
    assign :profile, profile
    assign :surahs, []
  end

  it_behaves_like 'a titled view'
end
