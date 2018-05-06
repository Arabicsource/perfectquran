# frozen_string_literal: true

module Admin
  class AccountsController < Admin::BaseController
    def index
      @resources = Account.all
    end

    def show
      @resource = Account.find(params[:id])
    end
  end
end
