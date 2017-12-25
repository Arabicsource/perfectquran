# frozen_string_literal: true

module Admin
  # :nodoc:
  class DashboardsController < Admin::BaseController
    def show
      @accounts = Account.all
      @comments = Comment.all
      @memories = Memory.all
    end
  end
end
