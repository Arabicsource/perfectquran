# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  username   :string
#  bio        :text
#  account_id :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
