# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# :nodoc:
class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :taggings
end