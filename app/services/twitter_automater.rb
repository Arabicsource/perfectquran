# frozen_string_literal: true

# :nodoc:
class TwitterAutomater
  def initialize
    @connections = Connection.all_active
  end

  def run!
    @connections.each do |connection|
      TwitterConnectionPoster.new(connection).run!
    end
  end
end
