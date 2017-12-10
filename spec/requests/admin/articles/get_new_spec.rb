# frozen_string_literal: true

require 'rails_helper'

describe 'GET Admin::Articles#new', type: :request do
  include_examples 'admin get request', '/admin/articles/new'
end
