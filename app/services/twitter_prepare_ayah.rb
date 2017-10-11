# frozen_string_literal: true

# :nodoc:
class TwitterPrepareAyah
  def initialize(surah, ayah, text)
    @surah = surah
    @ayah = ayah
    @text = text
  end

  def call
    build_reference
    build_url
    prepare_text
    tweetable_ayah
  end

  private

  def build_reference
    @reference = "[#{@surah}:#{@ayah}]"
  end

  def build_url
    @url = "https://perfectquran.co/#{@surah}/#{@ayah}"
  end

  def filter_brackets
    if @text.length > 140 - (reference_and_url_length + 1)
      @text = @text.gsub(/\[.*?\]/, '')
    end

    @text
  end

  def filter_parentheses
    if @text.length > 140 - (reference_and_url_length + 1)
      @text = @text.gsub(/\(.*?\)/, '')
    end

    @text
  end

  def prepare_text
    @text = @text.gsub('&#8217;', "'")
    filter_parentheses
    text_cleanup
    filter_brackets
    text_cleanup
    text_truncate
  end

  def reference_and_url_length
    "#{@reference} #{@url}".length
  end

  def text_cleanup
    @text = @text.gsub('  ', ' ')
                 .gsub(' .', '.')
                 .gsub('. .', '.')
                 .gsub(' .', '.')
                 .gsub(' ,', ',')
  end

  def text_truncate
    allowed_character_length = 140 - (reference_and_url_length + 1)

    if @text.length > allowed_character_length
      @text = @text.truncate(allowed_character_length)
    end

    @text
  end

  def tweetable_ayah
    "#{@text} #{@reference} #{@url}"
  end
end
