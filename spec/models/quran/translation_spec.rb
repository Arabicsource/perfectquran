# frozen_string_literal: true

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

  specify 'available_for_study' do
    actual = Quran::Translation.available_for_study.map(&:name)
    expected = ['Uthmani', 'Transliteration', 'The Noble Quran']

    expect(actual).to eq expected
  end
end
