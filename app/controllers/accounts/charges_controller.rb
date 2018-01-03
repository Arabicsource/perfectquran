# frozen_string_literal: true

module Accounts
  # :nodoc:
  class ChargesController < Accounts::BaseController
    def index
      @charges = Charge.where(account: current_account)
    end
  end
end
