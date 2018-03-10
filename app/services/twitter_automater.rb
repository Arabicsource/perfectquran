# frozen_string_literal: true

class TwitterAutomater
  def initialize
    @connections = Connection.all_active
  end

  def call
    @connections.each do |connection|
      TwitterConnectionPoster.new(connection).run!
    end
  end
end
