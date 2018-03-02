module CurrentAccount
  extend ActiveSupport::Concern

  included do
    before_action :set_account
  end

  private

  def set_account
    if current_account
      Current.account = current_account
    else
      Current.account = GuestAccount.new
    end
  end
end