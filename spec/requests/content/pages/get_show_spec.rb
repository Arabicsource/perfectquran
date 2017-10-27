# frozen_string_literal: true

require 'rails_helper'

describe 'Pages GET #show' do
  it 'responds successfully' do
    page = FactoryBot.create(:page)
    get content_page_path(page)
    expect(response).to be_successful
  end
end
