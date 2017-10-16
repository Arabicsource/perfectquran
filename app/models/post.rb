# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string
#  content     :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  permalink   :string
#
class Post < ApplicationRecord
  before_validation { self.permalink = title.parameterize if title }

  belongs_to :category
  belongs_to :user
  has_many :comments, as: :commentable

  validates :title, presence: true
  validates :permalink, uniqueness: { case_sensitive: false }
  validates :content, presence: true

  def visible_comments?
    comments.includes(:flag).where(flags: { comment_id: nil})
      .or(comments.includes(:flag).where( flags: { approved: true }))
      .present?
  end

  def author_name
    user.try(:name)
  end

  def category_name
    category.try(:name)
  end

  def category_name=(name)
    self.category = Category.find_or_create_by(name: name) if name.present?
  end
end
