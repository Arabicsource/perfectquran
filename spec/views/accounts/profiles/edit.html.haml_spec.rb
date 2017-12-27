# frozen_string_literal: true

require 'rails_helper'

describe 'accounts/profiles/edit' do
  let(:title) { 'Edit Profile' }

  before { assign :profile, build_stubbed(:profile) }

  it_behaves_like 'a titled view'
end
