# frozen_string_literal: true

module Accounts
  # :nodoc:
  class SubscriptionsController < Accounts::BaseController
    def new
      @subscription = Subscription.new
    end

    def create
      customer = Stripe::Customer.create(
        email: current_account.email,
        source: params['stripeToken']
      )

      subscription = Stripe::Subscription.create(
        customer: customer.id,
        items: [{ plan: 1 }]
      )

      @subscription = Subscription.new(
        account: current_account,
        customer_token: customer.id,
        subscription_token: subscription.id
      )

      if @subscription.save
        redirect_to accounts_profile_path
      else
        render :new
      end
    end
  end
end
