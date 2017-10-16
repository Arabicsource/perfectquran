# frozen_string_literal: true

require 'rails_helper'

# TwitterPrepareAyah.new(surah_id, ayah_number, ayah_text).call

RSpec.describe TwitterPrepareAyah do
  let(:ref_and_url) { '[1:1] https://perfectquran.co/1/1' }

  context 'all components length are equal to 140 characters or less' do
    it 'leaves the text unmodifed' do
      text = TwitterPrepareAyah.new(1, 1, 'a' * 106).call
      expect(text).to eq "#{'a' * 106} [1:1] https://perfectquran.co/1/1"
    end

    it 'keeps parentheses' do
      unmodified_text = "#{'a' * 49} (aaaaaaa) #{'a' * 40}"
      expected_result = "#{'a' * 49} (aaaaaaa) #{'a' * 40} #{ref_and_url}"

      text = TwitterPrepareAyah.new(1, 1, unmodified_text).call

      expect(text).to eq expected_result
      expect(text.length).to be <= 140
    end
  end

  context 'all components length are more than 140 characters' do
    it 'removes parenthesis' do
      unmodified_text = "#{'a' * 55} (aaaaaaa) #{'a' * 50}"
      expected_result = "#{'a' * 55} #{'a' * 50} #{ref_and_url}"

      text = TwitterPrepareAyah.new(1, 1, unmodified_text).call

      expect(text).to eq expected_result
      expect(text.length).to be <= 140
    end

    it 'removes square brackets' do
      unmodified_text = "#{'a' * 105} [aaaaaaa]."
      expected_result = "#{'a' * 105}. #{ref_and_url}"

      text = TwitterPrepareAyah.new(1, 1, unmodified_text).call

      expect(text).to eq expected_result
      expect(text.length).to be <= 140
    end

    it 'removes both parentheses and square brackets' do
      unmodified_text = "#{'a' * 13} [aaaaaaa], #{'a' * 90} (aaaaaaaa)."
      expected_result = "#{'a' * 13}, #{'a' * 90}. #{ref_and_url}"

      text = TwitterPrepareAyah.new(1, 1, unmodified_text).call

      expect(text).to eq expected_result
      expect(text.length).to be <= 140
    end

    context 'text has both () and [], removing () count is <= 140' do
      it 'removes just parentheses and leaves square brackets' do
        unmodified_text = "#{'a' * 10} [aaaaaaa], #{'a' * 77} (aaaaaaaa)."
        expected_result = "#{'a' * 10} [aaaaaaa], #{'a' * 77}. #{ref_and_url}"

        text = TwitterPrepareAyah.new(1, 1, unmodified_text).call

        expect(text).to eq expected_result
        expect(text.length).to be <= 140
      end
    end

    context 'after filtering text is too long' do
      it 'truncates the text' do
        unmodified_text = "#{'a' * 160}."
        expected_result = "#{'a' * 103}... #{ref_and_url}"

        text = TwitterPrepareAyah.new(1, 1, unmodified_text).call

        expect(text).to eq expected_result
        expect(text.length).to eq 140
      end
    end
  end
end
