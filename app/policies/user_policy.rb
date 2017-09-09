# frozen_string_literal: true

# :nodoc:
class UserPolicy < ApplicationPolicy
  def index?
    user.has_role?(:admin)
  end
end
