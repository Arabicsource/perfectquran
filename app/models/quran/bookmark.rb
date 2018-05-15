# frozen_string_literal: true

# == Schema Information
#
# Table name: bookmarks
#
#  id         :bigint(8)        not null, primary key
#  ayah_id    :bigint(8)
#  account_id :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module Quran
  class Bookmark < ApplicationRecord
    belongs_to :ayah
    belongs_to :account

    def to_s
      "Bookmark #{id}"
    end
  end
end
