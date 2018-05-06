# frozen_string_literal: true

# == Schema Information
#
# Table name: states
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  code       :string
#  country_id :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class State < ApplicationRecord
  belongs_to :country

  has_many :cities

  validates :name, presence: true
  validates :code, presence: true

  delegate :code, to: :country, prefix: true
  delegate :name, to: :country, prefix: true

  def to_s
    "State: #{name} (#{code})"
  end
end
