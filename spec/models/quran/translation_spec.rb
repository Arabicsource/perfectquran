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
  end

  specify 'available_for_posting' do
    actual = Quran::Translation.available_for_posting.map(&:name)
    expected = ['Uthmani', 'The Noble Quran', 'Yusuf Ali']

    expect(actual).to eq expected
  end

  specify 'available_for_quran' do
    actual = Quran::Translation.available_for_quran.map(&:name)
    expected = ['Uthmani', 'Transliteration', 'The Noble Quran']

    expect(actual).to eq expected
  end
end
