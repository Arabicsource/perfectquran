# frozen_string_literal: true

class Translation < ApplicationRecord
  belongs_to :language

  def self.available_for_posting
    where(id: [1, 3])
  end
end
