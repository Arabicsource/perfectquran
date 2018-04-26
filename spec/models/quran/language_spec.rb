# frozen_string_literal: true

# == Schema Information
#
# Table name: languages
#
#  id        :bigint(8)        not null, primary key
#  name      :string
#  direction :string
#

require 'rails_helper'

RSpec.describe Quran::Language, type: :model do
  describe 'associations' do
    it { is_expected.to have_many :translations }
  end

  specify 'translations_reading' do
    actual = Quran::Language.second.translations_reading.map(&:id)

    expect(actual).to eq [2, 3]
  end

  specify 'reading' do
    expect(Quran::Language.reading.map(&:id)).to eq [1, 2]
  end
end
