# frozen_string_literal: true

# == Schema Information
#
# Table name: favorites
#
#  id         :integer          not null, primary key
#  ayah_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :favorite do
    user
  end
end
