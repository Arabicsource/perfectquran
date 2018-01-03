# frozen_string_literal: true

require 'rails_helper'

describe 'POST Settings::Profiles#create', type: :request do
  let(:account) { create :account }
  let(:klass) { Profile }
  let(:url) { accounts_registrations_profile_path }
  let(:redirect_path) { new_accounts_registrations_memory_path }

  let :valid_params do
    { profile:
      { name: 'name123', username: 'username123', bio: 'bio123' } }
  end

  let :invalid_params do
    { profile: { name: 'a' * 51, username: 'a' * 51, bio: 'a' * 501 } }
  end

  it_behaves_like 'an account post request'
end
