# frozen_string_literal: true

# == Schema Information
#
# Table name: memories
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  ayah_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Memory < ApplicationRecord
  belongs_to :user
  belongs_to :ayah, counter_cache: true, class_name: 'Quran::Ayah'
end
