# frozen_string_literal: true

require 'rails_helper'

describe 'GET Admin::MenuLinks#new', type: :request do
  before { create :menu, id: 1 }

  include_examples 'admin get request', '/admin/menus/1/menu_links/new'
end
