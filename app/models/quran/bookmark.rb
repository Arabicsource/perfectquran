# frozen_string_literal: true

# == Schema Information
#
# Table name: quran_bookmarks
#
#  id                :integer          not null, primary key
#  bookmarkable_type :string
#  bookmarkable_id   :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

module Quran
  # :nodoc:
  class Bookmark < ApplicationRecord
    belongs_to :bookmarkable, polymorphic: true
  end
end
