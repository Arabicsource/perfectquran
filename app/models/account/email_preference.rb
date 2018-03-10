# frozen_string_literal: true

class Account
  # :nodoc:
  class EmailPreference < ApplicationRecord
    belongs_to :account
  end
end
