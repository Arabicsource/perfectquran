# frozen_string_literal: true

require 'rails_helper'

describe 'GET Admin::Categories#edit', type: :request do
  let(:admin) { create :admin_account }
  let(:url) { edit_admin_category_path(category) }
  let(:account) { create :account }
  let(:category) { create :category }

  it_behaves_like 'an admin get request'
end
