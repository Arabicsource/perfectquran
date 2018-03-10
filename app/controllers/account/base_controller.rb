# frozen_string_literal: true

class Account
  class BaseController < ApplicationController
    before_action :authenticate_account!
  end
end
