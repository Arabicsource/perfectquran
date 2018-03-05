# frozen_string_literal: true

# :nodoc:
class ApplicationController < ActionController::Base
  include CurrentAccount
end
