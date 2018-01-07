# frozen_string_literal: true

require 'rails_helper'

describe '/accounts/registrations/profiles/new', type: :request do
  let(:url) { new_accounts_registrations_profile_path }
  let(:account) { create :account }
  let(:title) { 'Tell Us About Yourself' }

  it_behaves_like 'an account get request'
end
