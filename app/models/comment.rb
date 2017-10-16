# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text
#  user_id          :integer
#  commentable_type :string
#  commentable_id   :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_one :flag

  validates :content, presence: true  

  def visible?
    flag.nil? or flag.approved?
  end

  def flagged?
    flag.present?
  end

  def approved?
    flag.present? and flag.approved?
  end
end
