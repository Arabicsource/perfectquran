# frozen_string_literal: true

class TwitterConnectionPoster
  def initialize(connection)
    @connection = connection
    @token = connection.token
    @secret = connection.secret
    @last_ayah_id = connection.last_ayah_id
    @translation = connection.translation
    @hashtags = connection.hashtags
  end

  def call
    post_tweet
    update_connection
  rescue StandardError
    false
  end

  private

  attr_reader :token, :secret

  def update_connection
    @connection.update_attribute(:last_ayah_id, current_ayah_id)
  end

  def post_tweet
    TwitterPoster.new(token, secret, twitterized_text).call
  end

  def twitterized_text
    AyahTwitterizer.new(text, current_ayah, @hashtags).run
  end

  def text
    Text.find_by!(translation: @translation, ayah: current_ayah).content
  end

  def current_ayah
    @current_ayah ||= Ayah.find_by!(id: current_ayah_id)
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
