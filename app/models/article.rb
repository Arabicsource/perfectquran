# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id             :bigint(8)        not null, primary key
#  title          :string
#  content        :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  visibility     :integer          default("draft")
#  permalink      :string
#  collection     :integer          default("post")
#  category_id    :bigint(8)
#  account_id     :bigint(8)
#  comments_count :integer          default(0)
#

class Article < ApplicationRecord
  default_scope { order created_at: :desc }

  scope :published_pages, -> { where collection: :page, visibility: :published }
  scope :published_posts, -> { where collection: :post, visibility: :published }

  delegate :name, to: :category, prefix: true

  before_validation { self.permalink = title.parameterize if title.present? }
  validates :title, presence: true
  validates :content, presence: true
  validates :permalink, presence: true, uniqueness: { case_sensitive: false }
  enum visibility: %i[draft published trash]
  enum collection: %i[post page]
  belongs_to :category
  belongs_to :account
  has_many :comments

  def author_name
    account.name
  end
end
