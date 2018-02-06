# frozen_string_literal: true

# :nodoc:
class RegistrationsController < Devise::RegistrationsController
  private def sign_up_params
    params.require(:account).permit(:email, :password, :password_confirmation)
  end

  def after_sign_up_path_for(_resource)
    accounts_root_path
  end
end
