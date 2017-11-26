# frozen_string_literal: true

require 'rails_helper'

describe 'admin/dashboards/show' do
  include Devise::Test::ControllerHelpers

  it 'provides a page title' do
    expect(view).to receive(:provide).with(:title, 'Dashboard')

    render
  end

  it 'has a level one heading' do
    render

    expect(rendered).to have_selector 'h1', text: 'Dashboard'
  end

  it 'does not have a newsletter signup section' do
    render template: 'admin/dashboards/show', layout: 'layouts/application'

    expect(rendered).not_to have_css 'section#newsletter'
  end

  it 'has a admin menu' do
    render template: 'admin/dashboards/show', layout: 'layouts/application'

    expect(rendered).to have_css 'nav#admin-menu'
  end
end
