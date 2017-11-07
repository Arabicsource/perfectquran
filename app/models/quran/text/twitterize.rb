# frozen_string_literal: true

module Quran
  class Text
    class Twitterize # :nodoc:
      TWITTER_CHAR_LIMIT = 140

      def initialize(text)
        @content = text.content
        @surah_id = text.ayah.surah_id
        @ayah_number = text.ayah.number
      end

      def call
        "#{content} #{reference} #{url}"
      end

      private

      def content
        filter_apostraphe_html_entities
        cleanup
        filter_parenthesis
        cleanup
        filter_square_brackets
        cleanup
        truncate
      end

      def reference
        @reference ||= "[#{@surah_id}:#{@ayah_number}]"
      end

      def url
        @url ||= "https://perfectquran.co/#{@surah_id}/#{@ayah_number}"
      end

      def filter_apostraphe_html_entities
        @content.gsub! '&#8217;', "'"
      end

      def filter_parenthesis
        return unless too_long?
        @content.gsub!(/\(.*?\)/, '')
      end

      def filter_square_brackets
        return unless too_long?
        @content.gsub!(/\[.*?\]/, '')
      end

      def cleanup
        @content.gsub! '  ', ' '
        @content.gsub! '. .', '.'
        @content.gsub! ' .', '.'
        @content.gsub! '..', '.'
        @content.gsub! ' ,', ','
      end

      def truncate
        @content.truncate allowed_character_length
      end

      def allowed_character_length
        TWITTER_CHAR_LIMIT - " #{reference} #{url}".length
      end

      def too_long?
        @content.length > allowed_character_length
      end
    end
  end
end
