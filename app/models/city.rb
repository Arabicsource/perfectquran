# frozen_string_literal: true

# == Schema Information
#
# Table name: cities
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  code       :string
#  state_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class City < ApplicationRecord
  belongs_to :state

  delegate :country_code, to: :state
  delegate :code, to: :state, prefix: true
  delegate :name, to: :state, prefix: true
end
