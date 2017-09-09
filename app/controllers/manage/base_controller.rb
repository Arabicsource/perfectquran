# frozen_string_literal: true

module Manage
  # :nodoc:
  class BaseController < ApplicationController
    before_action :authenticate_user!
  end
end
