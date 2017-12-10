# frozen_string_literal: true

require 'rails_helper'

describe 'GET Admin::Menus#index', type: :request do
  include_examples 'admin get request', '/admin/menus'
end
