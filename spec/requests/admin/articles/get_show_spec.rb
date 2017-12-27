# frozen_string_literal: true

require 'rails_helper'

describe 'GET Admin::Articles#show', type: :request do
  let(:admin) { create :admin_account }
  let(:url) { admin_article_path(article) }
  let(:account) { create :account }
  let(:article) { create :article }

  it_behaves_like 'an admin get request'
end
