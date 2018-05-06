# frozen_string_literal: true

module Admin
  class ConnectionsController < Admin::BaseController
    def index
      @resources = Connection.all
    end
  end
end
