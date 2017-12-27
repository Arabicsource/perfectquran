# frozen_string_literal: true

require 'rails_helper'

describe 'GET Admin::Articles#new', type: :request do
  let(:admin) { create :admin_account }
  let(:url) { new_admin_article_path }
  let(:account) { create :account }

  it_behaves_like 'an admin get request'
end
