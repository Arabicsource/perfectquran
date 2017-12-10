# frozen_string_literal: true

# == Schema Information
#
# Table name: menus
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# :nodoc:
class Menu < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  has_many :menu_links
end
