# frozen_string_literal: true

# == Schema Information
#
# Table name: translations
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  description :string
#  language_id :bigint(8)
#

require 'rails_helper'

RSpec.describe Quran::Translation, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :language }
    it { is_expected.to have_many :texts }
    it { is_expected.to have_many :account_translations }
  end

  specify 'posting' do
    actual = Quran::Translation.posting.map(&:name)
    expected = ['Uthmani', 'The Noble Quran', 'Yusuf Ali']

    expect(actual).to eq expected
  end

  specify 'reading' do
    actual = Quran::Translation.reading.map(&:name)
    expected = ['Uthmani', 'Transliteration', 'The Noble Quran']

    expect(actual).to eq expected
  end
end
