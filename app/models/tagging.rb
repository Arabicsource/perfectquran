# frozen_string_literal: true

class Tagging < ApplicationRecord
  belongs_to :account
  belongs_to :tag
  belongs_to :taggable, polymorphic: true

  validates :taggable_type, uniqueness: { scope: %i[tag_id taggable_id] }
end
