# frozen_string_literal: true

class Account
  # :nodoc:
  class ProfilesController < Account::BaseController
    before_action :load_profile, only: %i[edit update]

    def edit
      render layout: 'replacement'
    end

    def update
      if @profile.update_attributes(profile_params)
        flash[:success] = 'Alhamdulillah, Your profile was updated'
        redirect_to edit_account_profile_path
      else
        render :edit
      end
    end

    private

    def load_profile
      @profile = Profile.find_by(account: current_account)
    end

    def profile_params
      params.require(:profile).permit(:name, :username, :bio)
    end
  end
end
