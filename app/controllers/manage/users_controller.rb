# frozen_string_literal: true

module Manage
  # :nodoc:
  class UsersController < Manage::BaseController
    def index
      @users = User.all
    end
  end
end
