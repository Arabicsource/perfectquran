# frozen_string_literal: true

module Accounts
  module Registrations
    # :nodoc:
    class ProfilesController < Accounts::BaseController
      def edit
        @profile = Profile.find_by(account: current_account)
      end

      def update
        @profile = Profile.find_by(account: current_account)

        if @profile.update_attributes(profile_params)
          redirect_to new_accounts_registrations_memory_path
        else
          render :edit
        end
      end

      private

      def profile_params
        params.require(:profile).permit(:name, :username, :bio)
      end
    end
  end
end
