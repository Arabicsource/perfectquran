# frozen_string_literal: true

require 'rails_helper'

describe 'settings/profiles/new' do
  include Devise::Test::ControllerHelpers

  it 'provides a page title' do
    assign :profile, build_stubbed(:profile)

    expect(view).to receive(:provide).with(:title, 'Tell Us About Yourself')

    render
  end

  it 'has a level one heading' do
    assign :profile, build_stubbed(:profile)

    render

    expect(rendered).to have_selector 'h1', text: 'Tell Us About Yourself'
  end
end
