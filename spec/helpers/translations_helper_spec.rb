# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TranslationsHelper, type: :helper do
  specify 'translation_select_options' do
    actual = translation_select_options.to_str.squish.gsub('> <', '><')

    expect(actual).to eq expected_translation_select_options
  end

  private

  def expected_translation_select_options
    '<optgroup label="Arabic">
      <option value="1">Uthmani</option>
    </optgroup>
    <optgroup label="English">
      <option value="2">Transliteration</option>
      <option value="3">The Noble Quran</option>
    </optgroup>'.squish.gsub('> <', '><')
  end
end
