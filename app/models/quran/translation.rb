# frozen_string_literal: true

# == Schema Information
#
# Table name: translations
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  language_id :integer
#

module Quran
  # :nodoc:
  class Translation < ApplicationRecord
    belongs_to :language

    def self.available_for_posting
      where(id: [1, 3])
    end
  end
end
