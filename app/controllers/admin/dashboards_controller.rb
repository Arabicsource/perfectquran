# frozen_string_literal: true

module Admin
  class DashboardsController < Admin::BaseController
    def show
      @accounts = Account.all
      @comments = Comment.all
      @connections = Connection.all
    end
  end
end
