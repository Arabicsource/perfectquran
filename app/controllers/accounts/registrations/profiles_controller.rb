# frozen_string_literal: true

module Accounts
  module Registrations
    # :nodoc:
    class ProfilesController < Accounts::BaseController
      def new
        @profile = Profile.new
      end

      def create
        @profile = Profile.new(profile_params)
        @profile.account = current_account

        if @profile.save
          redirect_to new_accounts_registrations_memory_path
        else
          render :new
        end
      end

      private

      def profile_params
        params.require(:profile).permit(:name, :username, :bio)
      end
    end
  end
end
