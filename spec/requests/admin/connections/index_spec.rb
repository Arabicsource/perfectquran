# frozen_string_literal: true

require 'rails_helper'

describe 'Admin::Connections#index', type: :request do
  fixtures :translations

  let!(:connection) do
    create :connection
  end
  let(:admin) { create :account, :as_admin }
  let(:url) { admin_connections_path }
  let(:account) { create :account }
  let(:title) { 'Connections' }

  it_behaves_like 'an admin get request'
end
