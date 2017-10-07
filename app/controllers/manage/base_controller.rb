# frozen_string_literal: true

module Manage
  # :nodoc:
  class BaseController < ApplicationController
    layout 'manage'
    before_action :authenticate_user!, :authorize_user!

    private def authorize_user!
      redirect_to root_url unless current_user && current_user.role?(:admin)
    end
  end
end
