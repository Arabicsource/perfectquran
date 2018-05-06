# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Category < ApplicationRecord
  has_many :articles

  validates :name, presence: true
  validates :description, presence: true

  def to_s
    "Category: #{name}"
  end
end
