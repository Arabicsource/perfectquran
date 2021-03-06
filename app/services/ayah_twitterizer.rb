# frozen_string_literal: true

class AyahTwitterizer
  TWITTER_CHAR_LIMIT = 280

  def initialize(text, ayah, hashtags, translation_id)
    @text = text
    @ayah = ayah
    @hashtags = hashtags
    @translation_id = translation_id
  end

  def run
    "#{content} #{reference} #{url} #{hashtags}".strip
  end

  private

  attr_reader :hashtags, :ayah, :text, :translation_id

  def content
    filter_apostraphe_html_entities
    truncate
  end

  def url
    "https://perfectquran.co/#{translation_id}/#{ayah.surah_id}/#{ayah.number}"
  end

  def reference
    "[#{ayah.surah_id}:#{ayah.number}]"
  end

  def filter_apostraphe_html_entities
    @text = text.gsub '&#8217;', "'"
  end

  def truncate
    @text = text.truncate allowed_character_length
  end

  def allowed_character_length
    TWITTER_CHAR_LIMIT - " #{reference} #{url} #{hashtags}".length
  end
end
