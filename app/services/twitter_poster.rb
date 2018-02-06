# frozen_string_literal: true

# :nodoc:
class TwitterPoster
  def initialize(token, secret, text)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret = Rails.application.secrets.twitter_consumer_secret
      config.access_token = token
      config.access_token_secret = secret
    end

    @text = text
  end

  def call
    begin
      client.update(text)
      success_response
    rescue => exception
      failure_response(exception.message)
    end
  end

  private

  attr_reader :text, :client

  def success_response
    OpenStruct.new successful?: true
  end

  def failure_response(message)
    OpenStruct.new successful?: false, error: message
  end
end
