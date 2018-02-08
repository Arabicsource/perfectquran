# frozen_string_literal: true

require 'rails_helper'

describe '/account/memories/show', type: :request do
  let(:url) { account_memory_path }
  let(:account) { create :account }
  let(:title) { 'Hifz' }

  it_behaves_like 'an account get request'
end
