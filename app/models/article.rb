# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id             :integer          not null, primary key
#  title          :string
#  content        :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  visibility     :integer          default("draft")
#  permalink      :string
#  collection     :integer          default("post")
#  category_id    :integer
#  account_id     :integer
#  comments_count :integer          default(0)
#

# :nodoc:
class Article < ApplicationRecord
  default_scope { order created_at: :desc }

  scope :published_pages, -> { where collection: :page, visibility: :published }
  scope :published_posts, -> { where collection: :post, visibility: :published }

  delegate :name, to: :category, prefix: true

  before_validation { self.permalink = title.parameterize if title.present? }
  validates :title, presence: true
  validates :content, presence: true
  validates :permalink, presence: true, uniqueness: true
  enum visibility: %i[draft published trash]
  enum collection: %i[post page]
  belongs_to :category
  belongs_to :account
  has_many :comments
end
