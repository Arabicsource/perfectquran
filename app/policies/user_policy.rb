# frozen_string_literal: true

# :nodoc:
class UserPolicy < ApplicationPolicy
  def index?
    user.role?(:admin)
  end
end
