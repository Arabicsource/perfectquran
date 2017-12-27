# frozen_string_literal: true

require 'rails_helper'

describe 'GET Admin::MenuLinks#new', type: :request do
  let(:admin) { create :admin_account }
  let(:url) { new_admin_menu_menu_link_path(menu) }
  let(:account) { create :account }
  let(:menu) { create :menu }

  it_behaves_like 'an admin get request'
end
