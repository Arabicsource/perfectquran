# frozen_string_literal: true

class Account
  class SubscriptionsController < Account::BaseController
    before_action :load_subscription, only: %i[show update destroy]
    before_action :require_subscription, only: %i[update destroy]
    before_action :require_cancelled_subscription, only: :update
    before_action :require_active_subscription, only: :destroy

    def show
      return redirect_to new_account_subscription_path unless @subscription
      @charge = Charge.where(account: current_account).last
    end

    def new
      @subscription = Subscription.new
    end

    def create
      if subscribe_with_patron_subscriber
        flash[:success] = 'Alhamdulillah.'
        redirect_to account_subscription_path
      else
        flash[:danger] = 'An error prevented'
        render :new
      end
    end

    def update
      flash[:success] = if reactivate_patron_subscription
                          I18n.t('accounts.subscriptions.update.success')
                        else
                          I18n.t('accounts.subscriptions.update.error')
                        end

      redirect_to account_subscription_path
    end

    def destroy
      if cancel_patron_subscription
        flash[:success] = I18n.t('accounts.subscriptions.destroy.success')
      else
        flash[:error] = I18n.t('accounts.subscriptions.destroy.error')
      end

      redirect_to account_subscription_path
    end

    private

    def subscribe_with_patron_subscriber
      PatronSubscriber.new(current_account, params[:stripeToken], '1').call
    end

    def cancel_patron_subscription
      PatronSubscriptionCanceler.new(@subscription).call
    end

    def reactivate_patron_subscription
      PatronSubscriptionActivater.new(@subscription).call
    end

    def load_subscription
      @subscription = Subscription.find_by account: current_account
    end

    def require_subscription
      redirect_to edit_account_profile_path unless @subscription
    end

    def require_cancelled_subscription
      redirect_to account_subscription_path unless @subscription.cancelled?
    end

    def require_active_subscription
      redirect_to account_subscription_path unless @subscription.active?
    end
  end
end
