# frozen_string_literal: true

module Settings
  # :nodoc:
  class BaseController < ApplicationController
    before_action :authenticate_account!
  end
end
