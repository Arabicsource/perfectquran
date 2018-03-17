# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AyahTwitterizer do
  let(:text) { 'text123' }
  let(:ayah) { build_stubbed :ayah, number: 6, surah_id: 3 }
  let(:hashtags) { '#hashtag123' }
  let(:translation_id) { 3 }

  context 'when successful' do
    before do
      @result = AyahTwitterizer.new(text, ayah, hashtags, translation_id).run
    end

    it 'returns true' do
      expect(AyahTwitterizer.new(text, ayah, hashtags, translation_id).run)
        .to(be_truthy)
    end

    specify { expect(@result).to include 'text123' }
    specify { expect(@result).to include 'perfectquran.co/3/3/6' }
    specify { expect(@result).to include '[3:6]' }
    specify { expect(@result).to include '#hashtag123' }

    context 'with &#8217;' do
      let(:text) { 'text&#8217;123' }

      before do
        @result = AyahTwitterizer.new(text, ayah, hashtags, translation_id).run
      end

      specify { expect(@result).not_to include '&#8217;' }
      specify { expect(@result).to include "text'123" }
    end

    context 'when text is too long' do
      let(:text) { 'a' * 300 }

      before do
        @result = AyahTwitterizer.new(text, ayah, hashtags, translation_id).run
      end

      specify { expect(@result.length).to eq 280 }
    end

    context 'without hashtags' do
      let(:hashtags) { '' }
      let(:expected) { 'text123 [3:6] https://perfectquran.co/3/3/6' }

      before do
        @result = AyahTwitterizer.new(text, ayah, hashtags, translation_id).run
      end

      specify { expect(@result).to eq expected }
    end
  end
end
