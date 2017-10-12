# frozen_string_literal: true

module Settings
  # :nodoc:
  class GeneralsController < Settings::BaseController
    before_action :authenticate_user!

    def edit; end

    def update
      if current_user.update_attributes(general_params)
        flash[:success] = t 'settings.general.edited'
        redirect_to edit_settings_general_path
      else
        render :edit
      end
    end

    private def general_params
      params.require(:user).permit(:name, :username, :bio)
    end
  end
end
