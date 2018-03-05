# frozen_string_literal: true

class Account
  # :nodoc:
  class BaseController < ApplicationController
    before_action :authenticate_account!
  end
end
