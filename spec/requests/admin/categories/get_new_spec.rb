# frozen_string_literal: true

require 'rails_helper'

describe 'GET Admin::Categories#new', type: :request do
  let(:admin) { create :admin_account }
  let(:url) { new_admin_category_path }
  let(:account) { create :account }
  let(:title) { 'New Category' }

  it_behaves_like 'an admin get request'
end
