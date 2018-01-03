# frozen_string_literal: true

require 'rails_helper'

describe 'accounts/registrations/memories/new' do
  let(:title) { 'Have you memorized any of these Surahs?' }

  before { assign :commonly_memorized_surahs, [] }

  it_behaves_like 'a titled view'
end
