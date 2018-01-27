# frozen_string_literal: true

module Admin
  # :nodoc:
  class ConnectionsController < Admin::BaseController
    def index
      @connections = Connection.all
    end
  end
end
