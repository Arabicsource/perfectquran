# frozen_string_literal: true

require 'rails_helper'

describe 'GET Admin::Articles#edit', type: :request do
  let(:admin) { create :admin_account }
  let(:url) { edit_admin_article_path(article) }
  let(:account) { create :account }
  let(:article) { create :article }
  let(:title) { "Edit Article: #{article.title}" }

  it_behaves_like 'an admin get request'
end
