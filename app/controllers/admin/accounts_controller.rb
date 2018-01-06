# frozen_string_literal: true

module Admin
  # :nodoc:
  class AccountsController < Admin::BaseController
    def index
      @accounts = Account.all
    end
  end
end
