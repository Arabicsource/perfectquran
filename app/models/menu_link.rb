# frozen_string_literal: true

# == Schema Information
#
# Table name: menu_links
#
#  id         :integer          not null, primary key
#  name       :string
#  path       :string
#  menu_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# :nodoc:
class MenuLink < ApplicationRecord
  validates :name, presence: true
  validates :path, presence: true
  belongs_to :menu
end
