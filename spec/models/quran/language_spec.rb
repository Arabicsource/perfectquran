# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Quran::Language, type: :model do
  describe 'associations' do
    it { is_expected.to have_many :translations }
  end

  specify 'translations_available_for_study' do
    actual = Quran::Language.second.translations_available_for_study.map(&:id)

    expect(actual).to eq [2, 3]
  end

  specify 'available_for_study' do
    expect(Quran::Language.available_for_study.map(&:id)).to eq [1, 2]
  end
end
