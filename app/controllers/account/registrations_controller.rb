# frozen_string_literal: true

class Account
  # :nodoc:
  class RegistrationsController < Devise::RegistrationsController
    private def sign_up_params
      params.require(:account).permit(:email, :password, :password_confirmation)
    end

    def after_sign_up_path_for(_resource)
      account_root_path
    end
  end
end
