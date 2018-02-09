# frozen_string_literal: true

class Account
  # :nodoc:
  class EmailPreferencesController < Account::BaseController
    def edit
      @email_preference = current_account.email_preference
    end
  end
end
