# frozen_string_literal: true

require 'rails_helper'

describe 'GET Admin::Articles#index', type: :request do
  let(:admin) { create :admin_account }
  let(:url) { admin_articles_path }
  let(:account) { create :account }
  let(:title) { 'Articles' }

  it_behaves_like 'an admin get request'
end
