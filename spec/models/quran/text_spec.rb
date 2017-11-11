# frozen_string_literal: true

# == Schema Information
#
# Table name: texts
#
#  id             :integer          not null, primary key
#  content        :text
#  translation_id :integer
#  ayah_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Quran::Text, type: :model do
  subject { build_stubbed :text }

  it { is_expected.to belong_to(:translation).class_name('Quran::Translation') }
  it { is_expected.to belong_to :ayah }

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

  describe '#twitterize' do
    it 'has text' do
      ayah = build_stubbed :ayah
      text = build_stubbed :text, content: 'abc123', ayah: ayah

      expect(text.twitterize).to include 'abc123'
    end

    it 'has a url pointing to quran/ayahs#show' do
      ayah = build_stubbed :ayah, number: 6, surah_id: 3
      text = build_stubbed :text, ayah: ayah

      expect(text.twitterize).to include 'perfectquran.co/3/6'
    end

    it 'has a quranic reference' do
      ayah = build_stubbed :ayah, number: 6, surah_id: 3
      text = build_stubbed :text, ayah: ayah

      expect(text.twitterize).to include '[3:6]'
    end

    it 'replaces &#8217; with an apostrophe' do
      ayah = build_stubbed :ayah
      text = build_stubbed :text, ayah: ayah, content: 'aaa&#8217;aaa'

      expect(text.twitterize).not_to include '&#8217;'
      expect(text.twitterize).to include "aaa'aaa"
    end

    it 'replaces multiple spaces with a single space' do
      ayah = build_stubbed :ayah
      text = build_stubbed :text, ayah: ayah, content: 'aaa  aaa'

      expect(text.twitterize).not_to include '  '
      expect(text.twitterize).to include 'aaa aaa'
    end

    it 'removes space in front of dot' do
      ayah = build_stubbed :ayah
      text = build_stubbed :text, ayah: ayah, content: 'aaaaaa .'

      expect(text.twitterize).not_to include ' .'
      expect(text.twitterize).to include 'aaaaaa.'
    end

    it 'replaces dot space dot with a single dot' do
      ayah = build_stubbed :ayah
      text = build_stubbed :text, ayah: ayah, content: 'aaa. .aaa'

      expect(text.twitterize).not_to include '. .'
      expect(text.twitterize).to include 'aaa.aaa'
    end

    it 'removes space in front of comma' do
      ayah = build_stubbed :ayah
      text = build_stubbed :text, ayah: ayah, content: 'aaaaaa ,'

      expect(text.twitterize).not_to include ' ,'
      expect(text.twitterize).to include 'aaaaaa,'
    end

    it 'replaces double dots with single dot' do
      ayah = build_stubbed :ayah
      text = build_stubbed :text, ayah: ayah, content: 'aaa..aaa'

      expect(text.twitterize).not_to include '..'
      expect(text.twitterize).to include 'aaa.aaa'
    end

    context 'text, reference and url are less than 140 characters' do
      it 'Leaves parenthesis in place' do
        ayah = build_stubbed :ayah
        content = '321cba (abc123)'
        text = build_stubbed :text, ayah: ayah, content: content

        expect(text.twitterize).to include '(abc123)'
      end

      it 'leaves square brackets in place' do
        ayah = build_stubbed :ayah
        content = '321cba [abc123]'
        text = build_stubbed :text, ayah: ayah, content: content

        expect(text.twitterize).to include '[abc123]'
      end
    end

    context 'text, reference and url are more than 140 characters' do
      it 'has a length of 280 characters' do
        ayah = build_stubbed :ayah
        content = ('a' * 300).to_s
        text = build_stubbed :text, ayah: ayah, content: content

        expect(text.twitterize.length).to eq 280
      end

      it 'removes parenthesis' do
        ayah = build_stubbed :ayah
        content = "#{'a' * 200} (abc123) #{'a' * 100}"
        text = build_stubbed :text, ayah: ayah, content: content

        expect(text.twitterize).not_to include '(abc123)'
      end

      it 'removes square brackets' do
        ayah = build_stubbed :ayah
        content = "#{'a' * 200} [abc123] #{'a' * 100}"
        text = build_stubbed :text, ayah: ayah, content: content

        expect(text.twitterize).not_to include '[abc123]'
      end
    end
  end
end
