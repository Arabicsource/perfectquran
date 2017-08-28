class Topic < ApplicationRecord
  belongs_to :discussable, polymorphic: true
  belongs_to :user

  has_many :comments

  validates :subject, presence: true
  validates :content, presence: true
end
