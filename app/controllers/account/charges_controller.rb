# frozen_string_literal: true

class Account
  # :nodoc:
  class ChargesController < Account::BaseController
    def index
      @charges = Charge.where(account: current_account)
    end
  end
end
