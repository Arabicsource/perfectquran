# frozen_string_literal: true

require 'rails_helper'

describe 'GET Admin::Categories#index', type: :request do
  include_examples 'admin get request', '/admin/categories'
end
