# frozen_string_literal: true

require 'rails_helper'

describe 'content/articles/index' do
  let(:title) { 'Blog' }

  before { assign :articles, [] }

  it_behaves_like 'a titled view'
end
