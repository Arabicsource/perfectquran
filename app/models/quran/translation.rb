# frozen_string_literal: true

# == Schema Information
#
# Table name: translations
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  language_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

module Quran
  # :nodoc:
  class Translation < ApplicationRecord
    belongs_to :language
  end
end
