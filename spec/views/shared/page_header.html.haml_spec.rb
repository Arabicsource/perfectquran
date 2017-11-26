# frozen_string_literal: true

require 'rails_helper'

describe 'shared/_page_header' do
  it 'has a header element' do
    render 'shared/page_header', title: 'title'

    expect(rendered).to have_selector 'header'
  end

  it 'has a level one heading' do
    render 'shared/page_header', title: 'abc123'

    expect(rendered).to have_selector 'h1', text: 'abc123'
  end
end
