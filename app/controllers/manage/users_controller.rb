# frozen_string_literal: true

module Manage
  # :nodoc:
  class UsersController < Manage::BaseController
    def index
      @users = Account.all
    end

    def show
      @user = Account.find(params[:id])
    end
  end
end
