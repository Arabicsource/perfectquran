# frozen_string_literal: true

class Account
  module Translations
    class OrdersController < Account::BaseController
      def update
        account_translation = AccountTranslation.find(params[:id])
        account_translation.update_attribute(:order, params[:order].to_i)
      end
    end
  end
end
