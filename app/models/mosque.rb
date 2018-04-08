class Mosque < ApplicationRecord
  belongs_to :city

  validates :name, presence: true

  delegate :country_code, to: :city
  delegate :name, to: :city, prefix: true
  delegate :state_code, to: :city

  def location
    "#{city_name}, #{state_code}, #{country_code}"
  end
end
