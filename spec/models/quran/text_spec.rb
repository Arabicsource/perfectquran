# frozen_string_literal: true

# == Schema Information
#
# Table name: quran_texts
#
#  id             :integer          not null, primary key
#  content        :text
#  translation_id :integer
#  ayah_id        :integer
#

require 'rails_helper'

RSpec.describe Text, type: :model do
  subject { build_stubbed :text }

  it { is_expected.to belong_to(:translation) }
  it { is_expected.to belong_to :ayah }
  it { is_expected.to have_one(:surah).through(:ayah) }

  describe '#reference' do
    it 'returns a reference to the ayah the text belongs to' do
      surah = create :surah, id: 2
      ayah = create :ayah, number: 3, surah: surah
      text = create :text, ayah: ayah

      expect(text.reference).to eq '[2:3]'
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
