# frozen_string_literal: true

require 'rails_helper'

describe '/accounts/registrations/memories/new', type: :request do
  let(:url) { new_accounts_registrations_memory_path }
  let(:account) { create :account }
  let(:title) { 'Have you memorized any of these Surahs?' }

  it_behaves_like 'an account get request'
end
