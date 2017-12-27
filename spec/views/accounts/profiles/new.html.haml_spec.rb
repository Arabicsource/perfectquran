# frozen_string_literal: true

require 'rails_helper'

describe 'accounts/profiles/new' do
  let(:title) { 'Tell Us About Yourself' }

  before { assign :profile, build_stubbed(:profile) }

  it_behaves_like 'a titled view'
end
