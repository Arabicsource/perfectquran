# frozen_string_literal: true

module Settings
  # :nodoc:
  class ProfilesController < Settings::BaseController
    def new
      @profile = Profile.new
    end

    def create
      @profile = Profile.new(profile_params)
      @profile.account = current_account

      if @profile.save
        flash[:success] = 'Thank you for..'
        redirect_to root_path
      else
        render :new
      end
    end

    def edit
      @profile = Profile.find_or_create_by(account: current_account)
    end

    def update
      @profile = current_account.profile

      if @profile.update_attributes(profile_params)
        flash[:success] = 'Alhamdulillah, Your profile was updated'
        redirect_to edit_settings_profile_path
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
