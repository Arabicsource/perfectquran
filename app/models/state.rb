class State < ApplicationRecord
  belongs_to :country

  delegate :code, to: :country, prefix: true
  delegate :name, to: :country, prefix: true
end
