# frozen_string_literal: true

module Manage
  # :nodoc:
  class UsersController < Manage::BaseController
    def index
      authorize User
      @users = User.all
    end
  end
end
