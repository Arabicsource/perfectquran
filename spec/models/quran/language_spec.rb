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

  specify 'translations_available_for_quran' do
    actual = Quran::Language.second.translations_available_for_quran.map(&:id)

    expect(actual).to eq [2, 3]
  end

  specify 'available_for_quran' do
    expect(Quran::Language.available_for_quran.map(&:id)).to eq [1, 2]
  end
end
