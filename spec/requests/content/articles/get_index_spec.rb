# frozen_string_literal: true

require 'rails_helper'

describe 'GET Content::Articles#index', type: :request do
  it 'responds successfully' do
    create :article, visibility: 'published'

    get content_articles_path

    expect(response).to be_successful
  end

  context 'when mobile' do
    before do
      mobile_browser
      get content_articles_path
    end

    specify { expect(response).to be_successful }
  end
end
