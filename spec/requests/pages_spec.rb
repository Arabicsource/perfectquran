# frozen_string_literal: true

require 'rails_helper'

describe 'Pages' do
  let(:page) { FactoryGirl.create(:page) }

  describe 'GET #show' do
    before { get page_path(page.permalink) }
    specify { expect(response).to be_successful }
    specify { expect(response.body).to include page.title }
    specify { expect(response.body).to include page.content }
  end
end
