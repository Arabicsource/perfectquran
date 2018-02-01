# frozen_string_literal: true

require 'rails_helper'

describe '/accounts/memories/show', type: :request do
  let(:url) { accounts_memory_path }
  let(:account) { create :account }
  let(:title) { 'Hifz' }

  it_behaves_like 'an account get request'
end
