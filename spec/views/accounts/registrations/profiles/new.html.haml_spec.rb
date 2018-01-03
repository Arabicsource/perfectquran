# frozen_string_literal: true

require 'rails_helper'

describe 'accounts/registrations/profiles/new' do
  let(:title) { 'Tell Us About Yourself' }

  before { assign :profile, Profile.new }

  it_behaves_like 'a titled view'
end
