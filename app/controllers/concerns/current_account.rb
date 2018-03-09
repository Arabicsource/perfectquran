# frozen_string_literal: true

# :nodoc:
module CurrentAccount
  extend ActiveSupport::Concern

  included do
    before_action :set_account
  end

  private

  def set_account
    Current.account = current_account ? current_account : GuestAccount.new
  end
end
