# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  title       :string
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  visibility  :integer          default("draft")
#  permalink   :string
#  collection  :integer          default("post")
#  category_id :integer
#  user_id     :integer
#

# :nodoc:
class Article < ApplicationRecord
  default_scope { order created_at: :desc }
  before_validation { self.permalink = title.parameterize if title.present? }
  validates :title, presence: true
  validates :content, presence: true
  validates :permalink, presence: true, uniqueness: true
  enum visibility: %i[draft published trash]
  enum collection: %i[post page]
  belongs_to :category
  belongs_to :user
  has_many :comments
end
