# frozen_string_literal: true

# == Schema Information
#
# Table name: bookmarks
#
#  id                :bigint(8)        not null, primary key
#  bookmarkable_type :string
#  bookmarkable_id   :bigint(8)
#  account_id        :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

# :nodoc:
class Bookmark < ApplicationRecord
  belongs_to :bookmarkable, polymorphic: true
  belongs_to :account
end
