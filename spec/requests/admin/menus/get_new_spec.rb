# frozen_string_literal: true

require 'rails_helper'

describe 'GET /admin/menus/new', type: :request do
  let(:admin) { create :admin_account }
  let(:url) { new_admin_menu_path }
  let(:account) { create :account }

  it_behaves_like 'an admin get request'
end
