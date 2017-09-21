# frozen_string_literal: true

module Manage
  # :nodoc:
  class BaseController < ApplicationController
    before_action :authenticate_user!, :authorize_user!

    private def authorize_user!
      unless current_user && current_user.role?(:admin)
        redirect_to root_url
      end
    end
  end
end
