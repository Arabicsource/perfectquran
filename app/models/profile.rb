# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  name       :string
#  username   :string
#  bio        :text
#  account_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
