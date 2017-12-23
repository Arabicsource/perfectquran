# frozen_string_literal: true

# :nodoc:
class SubscriptionsController < ApplicationController
  def new
    @subscription = Subscription.new
  end
end
