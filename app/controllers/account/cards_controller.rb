# frozen_string_literal: true

class Account
  class CardsController < Account::BaseController
    def edit; end

    def update
      if update_payment_method
        flash[:success] = 'Your payment method has been updated'
        redirect_to account_subscription_path
      else
        render :edit
      end
    end

    private

    def update_payment_method
      subscription = Subscription.find_by(account: current_account)
      PaymentMethodUpdater.new(subscription, params[:stripeToken]).call
    end
  end
end
