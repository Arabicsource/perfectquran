# frozen_string_literal: true

# :nodoc:
class ApplicationController < ActionController::Base
  layout :select_layout

  protect_from_forgery with: :exception

  private

  def select_layout
    'mobile' if browser.mobile?
  end
end
