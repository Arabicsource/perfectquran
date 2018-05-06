# frozen_string_literal: true

# == Schema Information
#
# Table name: countries
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  code       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Country < ApplicationRecord
  has_many :states

  validates :name, presence: true
  validates :code, presence: true

  def to_s
    "Country: #{name} (#{code})"
  end
end
