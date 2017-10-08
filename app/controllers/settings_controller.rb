# frozen_string_literal: true

# :nodoc:
class SettingsController < ApplicationController
  def index
    authenticate_user!
  end
end
