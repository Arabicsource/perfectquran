# frozen_string_literal: true

# :nodoc:
class Bookmark < ApplicationRecord
  belongs_to :bookmarkable, polymorphic: true
  belongs_to :account
end
