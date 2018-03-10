# frozen_string_literal: true

class Account
  class RegistrationsController < Devise::RegistrationsController
    private def sign_up_params
      params.require(:account).permit(:email, :password, :password_confirmation)
    end
  end
end
