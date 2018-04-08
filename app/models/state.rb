class State < ApplicationRecord
  belongs_to :country

  delegate :name, to: :country, prefix: true
end
