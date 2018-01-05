# frozen_string_literal: true

# :nodoc:
class TwitterConnectionPoster
  def initialize(connection)
    @connection = connection
    @token = connection.token
    @secret = connection.secret
    @last_ayah_id = connection.last_ayah_id
  end

  def run!
    post_tweet
    update_connection
  rescue
    false
  end

  private

  attr_reader :token, :secret

  def update_connection
    @connection.update_attribute(:last_ayah_id, current_ayah_id)
  end

  def post_tweet
    TwitterPoster.new(token, secret, twitterized_text).run!
  end

  def twitterized_text
    Quran::Text.find_by!(translation_id: 3, ayah_id: current_ayah_id).twitterize
  end

  def current_ayah_id
    @current_ayah_id ||= if @last_ayah_id < 1
                           1
                         elsif @last_ayah_id > 6235
                           1
                         else
                           @last_ayah_id + 1
                         end
  end
end
