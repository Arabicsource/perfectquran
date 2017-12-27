# frozen_string_literal: true

require 'rails_helper'

describe 'quran/surahs/index' do
  let(:title) { 'Suwar' }

  before { assign :surahs, [] }

  it_behaves_like 'a titled view'
end
