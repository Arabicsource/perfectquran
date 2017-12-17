# frozen_string_literal: true

# :nodoc:
class RegistrationsController < Devise::RegistrationsController
  private def sign_up_params
    params.require(:account)
          .permit(:name, :username, :email, :password, :password_confirmation)
  end
end
