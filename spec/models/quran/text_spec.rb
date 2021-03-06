# frozen_string_literal: true

# == Schema Information
#
# Table name: texts
#
#  id             :bigint(8)        not null, primary key
#  content        :text
#  translation_id :bigint(8)
#  ayah_id        :bigint(8)
#

require 'rails_helper'

RSpec.describe Quran::Text, type: :model do
  it { is_expected.to belong_to(:translation) }
  it { is_expected.to belong_to :ayah }
  it { is_expected.to have_one(:surah).through(:ayah) }

  describe '#reference' do
    it 'returns a reference to the ayah the text belongs to' do
      text = Quran::Text.where(ayah_id: 7).first

      expect(text.reference).to eq '[1:7]'
    end
  end

  describe '#uthmani?' do
    it 'returns false if translation_id is not 1' do
      subject.translation_id = 2
      expect(subject.uthmani?).to be_falsey
    end

    it 'returns true if translation_id is 1' do
      subject.translation_id = 1
      expect(subject.uthmani?).to be_truthy
    end
  end
end
