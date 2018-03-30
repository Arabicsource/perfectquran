# frozen_string_literal: true

require 'rails_helper'

describe 'Admin::Connections#index', type: :request do
  let!(:connection) { create :connection }
  let(:admin) { create :account, :as_admin }
  let(:url) { admin_connections_path }
  let(:account) { create :account }
  let(:title) { 'Connections' }

  it_behaves_like 'an admin get request'
end
