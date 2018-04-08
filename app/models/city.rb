class City < ApplicationRecord
  belongs_to :state

  delegate :country_code, to: :state
  delegate :name, to: :state, prefix: true
end
