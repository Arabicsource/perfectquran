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

FactoryBot.define do
  factory :menu_link do
    name 'name_string'
    path '/path/string'
  end
end
