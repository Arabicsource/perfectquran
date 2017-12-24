# frozen_string_literal: true

require 'rails_helper'

describe 'accounts/profiles/show' do
  # include Devise::Test::ControllerHelpers

  it 'provides a page title' do
    # assign :profile, build_stubbed(:profile)

    expect(view).to receive(:provide).with(:title, 'Profile')

    render
  end

  it 'has a level one heading' do
    # assign :profile, build_stubbed(:profile)

    render

    expect(rendered).to have_selector 'h1', text: 'Profile'
  end
end
