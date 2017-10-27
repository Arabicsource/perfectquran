# frozen_string_literal: true

require 'rails_helper'

describe 'Blog Categories', type: :request do
  let(:category) { FactoryBot.create(:category) }

  describe 'GET #show' do
    before { get blog_category_path(category) }
    specify { expect(response).to be_successful }
    specify { expect(response.body).to include category.name }
  end
end
