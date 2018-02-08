# frozen_string_literal: true

class Account
  # :nodoc:
  class ProfilesController < Account::BaseController
    before_action :load_profile, only: %i[show edit update]

    def show
      @total_points = Quran::Ayah.joins(:memories)
                                 .where(memories: { account: current_account })
                                 .sum(:character_length) * 3
      @surahs = Quran::Surah.joins(:memories)
                            .where(memories: { account: current_account }).uniq
    end

    def edit; end

    def update
      if @profile.update_attributes(profile_params)
        flash[:success] = 'Alhamdulillah, Your profile was updated'
        redirect_to account_profile_path
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
