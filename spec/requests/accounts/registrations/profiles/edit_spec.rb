# frozen_string_literal: true

require 'rails_helper'

describe '/accounts/registrations/profiles/edit', type: :request do
  let(:url) { edit_accounts_registrations_profile_path }
  let(:account) { create :account }
  let(:title) { 'Tell Us About Yourself' }

  it_behaves_like 'an account get request'
end
