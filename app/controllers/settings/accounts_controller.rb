# frozen_string_literal: true

module Settings
  # :nodoc:
  class AccountsController < Settings::BaseController
    def edit; end

    def update
      if current_user.update_attributes(account_settings_params)
        flash[:success] = I18n.t(
          'settings.accounts.update.success_notification'
        )
        redirect_to edit_settings_account_path
      else
        render :edit
      end
    end

    private

    def account_settings_params
      params.require(:user).permit(:name, :username, :bio)
    end
  end
end
