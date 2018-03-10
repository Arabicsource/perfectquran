# frozen_string_literal: true

# :nodoc:
class Profile < ApplicationRecord
  belongs_to :account
  validates :name, length: { maximum: 50 }
  validates :username,
            length: { maximum: 50 },
            uniqueness: { case_sensitive: false },
            format: {
              with: /\A\w+\z/,
              message: 'only Letters, numbers and underscores'
            },
            allow_blank: true
  validates :bio, length: { maximum: 500 }
end
