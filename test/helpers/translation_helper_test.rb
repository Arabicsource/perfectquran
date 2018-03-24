class TranslationHelperTest < ActionView::TestCase
  test 'translation_select_options' do
    assert_dom_equal(
      expected_translation_select_options,
      translation_select_options.to_str.squish.gsub('> <', '><')
    )
  end

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