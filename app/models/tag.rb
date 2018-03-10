# frozen_string_literal: true

# :nodoc:
class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :taggings
end
