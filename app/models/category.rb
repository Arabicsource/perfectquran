# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# :nodoc:
class Category < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
end
