# frozen_string_literal: true

RSpec.shared_examples 'a titled view' do
  it 'provides a page title' do
    expect(view).to receive(:provide).with(:title, title)

    render
  end

  it 'has a level one heading' do
    render

    expect(rendered).to have_selector 'h1', text: title
  end
end
