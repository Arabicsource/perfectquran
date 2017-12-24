# frozen_string_literal: true

module Accounts
  # :nodoc:
  class BaseController < ApplicationController
    before_action :authenticate_account!
  end
end
