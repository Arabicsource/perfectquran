# frozen_string_literal: true

# == Schema Information
#
# Table name: mosques
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  phone      :string
#  email      :string
#  street     :string
#  city       :string
#  state      :string
#  country    :string
#  zip_code   :string
#  website    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  city_id    :bigint(8)
#

class Mosque < ApplicationRecord
  belongs_to :city

  validates :name, presence: true

  delegate :country_code, to: :city
  delegate :country_name, to: :city
  delegate :name, to: :city, prefix: true
  delegate :state_code, to: :city
  delegate :state_name, to: :city

  def location
    "#{city_name}, #{state_code}, #{country_code}"
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def to_s
    "Mosque: #{name}"
  end
end
