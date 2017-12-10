# frozen_string_literal: true

require 'rails_helper'

describe 'admin/articles/index' do
  context 'behaves like an admin view' do
    before { assign :articles, [] }
    it_behaves_like 'admin view', 'Articles', 'admin/articles/index'
  end
end
