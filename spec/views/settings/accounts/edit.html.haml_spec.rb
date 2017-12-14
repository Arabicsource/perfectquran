# frozen_string_literal: true

require 'rails_helper'

describe 'settings/accounts/edit' do
  include Devise::Test::ControllerHelpers

  it 'provides a page title' do
    allow(view).to receive(:current_user).and_return(build_stubbed(:member))

    expect(view).to receive(:provide).with(:title, 'Edit Account Settings')

    render
  end

  it 'has a level one heading' do
    allow(view).to receive(:current_user).and_return(build_stubbed(:member))

    render

    expect(rendered).to have_selector 'h1', text: 'Edit Account Settings'
  end
end
