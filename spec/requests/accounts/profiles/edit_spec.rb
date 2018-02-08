# frozen_string_literal: true

require 'rails_helper'

describe '/account/profiles/edit', type: :request do
  let(:url) { edit_account_profile_path }
  let(:account) { create :account }
  let(:title) { 'Edit Profile' }

  it_behaves_like 'an account get request'
end
