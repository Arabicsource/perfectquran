# frozen_string_literal: true

require 'rails_helper'

describe 'GET Admin::Dashboards#show', type: :request do
  include_examples 'admin get request', '/admin'
end
