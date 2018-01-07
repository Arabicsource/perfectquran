# frozen_string_literal: true

require 'rails_helper'

describe 'GET Admin::MenuLinks#edit', type: :request do
  let(:admin) { create :admin_account }
  let(:url) { edit_admin_menu_menu_link_path(menu, menu_link) }
  let(:account) { create :account }
  let(:menu) { create :menu }
  let(:menu_link) { create :menu_link, menu: menu }
  let(:title) { "Edit Menu Link: #{menu_link.name}" }

  it_behaves_like 'an admin get request'
end
