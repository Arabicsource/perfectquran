# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ayah, type: :model do
  describe 'belongs_to associations' do
    it { is_expected.to belong_to :surah }
    it { is_expected.to belong_to :page }
    it { is_expected.to belong_to :juz }
  end

  describe 'has_many associations' do
    it { is_expected.to have_many :memories }
    it { is_expected.to have_many :bookmarks }
    it { is_expected.to have_many :texts }

    it do
      is_expected.to(
        have_many(:texts_and_included_translations)
      )
    end

    it { is_expected.to have_many :taggings }
    it { is_expected.to have_many(:tags).through(:taggings) }
  end
end
