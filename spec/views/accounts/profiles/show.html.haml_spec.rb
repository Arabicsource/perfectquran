# frozen_string_literal: true

require 'rails_helper'

describe 'accounts/profiles/show' do
  include Devise::Test::ControllerHelpers

  it 'provides a page title' do
    allow(view).to receive(:current_account).and_return(create(:account))
    assign :profile, build_stubbed(:profile)
    assign :surahs, []

    expect(view).to receive(:provide).with(:title, 'Profile')

    render
  end

  it 'has a level one heading' do
    allow(view).to receive(:current_account).and_return(create(:account))
    assign :profile, build_stubbed(:profile)
    assign :surahs, []

    render

    expect(rendered).to have_selector 'h1', text: 'Profile'
  end
end
