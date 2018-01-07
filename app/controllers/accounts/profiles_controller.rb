# frozen_string_literal: true

module Accounts
  # :nodoc:
  class ProfilesController < Accounts::BaseController
    def show
      @profile = Profile.find_or_create_by(account: current_account)
      @total_points = Quran::Ayah.joins(:memories)
                                 .where(memories: { account: current_account })
                                 .sum(:character_length) * 3
      @surahs = Quran::Surah.joins(:memories)
                            .where(memories: { account: current_account }).uniq
    end

    def create
      @profile = Profile.new(profile_params)
      @profile.account = current_account

      if @profile.save
        redirect_to accounts_profile_path
      else
        render :edit
      end
    end

    def edit
      @profile = Profile.find_or_create_by(account: current_account)
    end

    def update
      @profile = Profile.find_by(account: current_account)

      if @profile.update_attributes(profile_params)
        flash[:success] = 'Alhamdulillah, Your profile was updated'
        redirect_to accounts_profile_path
      else
        render :edit
      end

      # raise @profile.to_yaml
    end

    private

    def profile_params
      params.require(:profile).permit(:name, :username, :bio)
    end
  end
end
