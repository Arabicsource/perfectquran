# frozen_string_literal: true

module Manage
  # :nodoc:
  class UsersController < Manage::BaseController
    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
    end
  end
end
