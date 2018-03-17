# frozen_string_literal: true

class TwitterAutomater
  def initialize(frequency:)
    @connections = Connection.send(frequency)
  end

  def call
    @connections.each do |connection|
      TwitterConnectionPoster.new(connection).call
    end
  end
end
