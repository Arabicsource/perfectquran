# frozen_string_literal: true

# :nodoc:
class ApplicationController < ActionController::Base
  layout :select_layout

  private

  def select_layout
    'mobile' if browser.mobile?
  end
end
