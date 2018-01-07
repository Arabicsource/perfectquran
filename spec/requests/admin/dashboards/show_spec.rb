# frozen_string_literal: true

require 'rails_helper'

describe 'GET Admin::Dashboards#show', type: :request do
  let(:admin) { create :admin_account }
  let(:url) { admin_root_path }
  let(:account) { create :account }
  let(:title) { 'Dashboard' }

  it_behaves_like 'an admin get request'
end
