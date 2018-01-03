# frozen_string_literal: true

module Accounts
  module Registrations
    # :nodoc:
    class SubscriptionsController < Accounts::BaseController
      def new; end

      def create
        if subscribe_with_patron_subscriber
          flash[:success] = 'Alhamdulillah.'
          redirect_to accounts_profile_path
        else
          flash[:danger] = 'An error prevented'
          render :new
        end
      end

      private

      def subscribe_with_patron_subscriber
        PatronSubscriber.new(current_account, params[:stripeToken], '1').run!
      end
    end
  end
end
