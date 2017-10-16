module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :commentable
  end

  def visible_comments?
    comments.includes(:flag).where(flags: { comment_id: nil})
      .or(comments.includes(:flag).where( flags: { approved: true }))
      .present?
  end
end