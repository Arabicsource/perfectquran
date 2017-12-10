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

FactoryBot.define do
  factory :menu do
    name 'name_string'
    description 'description_string'
  end
end
