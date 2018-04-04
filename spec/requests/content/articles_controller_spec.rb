# frozen_string_literal: true

require 'rails_helper'

describe 'Content::ArticlesController', type: :request do
  describe 'blog_path' do
    before do
      create_list :post, 3
      get blog_path
    end

    specify { expect(response).to be_successful }
  end
end
