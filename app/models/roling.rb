# frozen_string_literal: true

# == Schema Information
#
# Table name: rolings
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  role_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Roling < ApplicationRecord
  belongs_to :user
  belongs_to :role
end
