class City < ApplicationRecord
  belongs_to :state

  delegate :country_code, to: :state
  delegate :code, to: :state, prefix: true
  delegate :name, to: :state, prefix: true
end
