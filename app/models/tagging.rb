# frozen_string_literal: true

# == Schema Information
#
# Table name: taggings
#
#  id            :integer          not null, primary key
#  account_id    :integer
#  tag_id        :integer
#  taggable_type :string
#  taggable_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# :nodoc:
class Tagging < ApplicationRecord
  belongs_to :account
  belongs_to :tag
  belongs_to :taggable, polymorphic: true

  validates :taggable_type, uniqueness: { scope: %i[tag_id taggable_id] }
end
