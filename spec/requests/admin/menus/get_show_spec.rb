# frozen_string_literal: true

require 'rails_helper'

describe 'GET Admin::Menus#show', type: :request do
  let(:admin) { create :admin_account }
  let(:url) { admin_menu_path(menu) }
  let(:account) { create :account }
  let(:menu) { create :menu }

  it_behaves_like 'an admin get request'
end
