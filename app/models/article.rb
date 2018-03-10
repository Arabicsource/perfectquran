# frozen_string_literal: true

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

  def author_name
    account.name
  end
end
