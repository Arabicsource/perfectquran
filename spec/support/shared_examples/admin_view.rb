# frozen_string_literal: true

RSpec.shared_examples 'admin view' do |title, template|
  include Devise::Test::ControllerHelpers

  it 'provides a page title' do
    expect(view).to receive(:provide).with(:title, title)

    render
  end

  it 'has a level one heading' do
    render

    expect(rendered).to have_selector 'h1', text: title
  end

  it 'has a admin menu' do
    allow(view).to receive(:params).and_return(controller: 'admin')

    render template: template, layout: 'layouts/application'

    expect(rendered).to have_css 'nav#admin-menu'
  end
end
