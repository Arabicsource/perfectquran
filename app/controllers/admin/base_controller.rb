# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    layout 'admin'

    before_action :authenticate_account!, :authorize_account!

    private def authorize_account!
      redirect_to root_url unless current_account.try(:role?, :admin)
    end
  end
end
