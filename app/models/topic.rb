class Topic < ApplicationRecord
  belongs_to :discussable, polymorphic: true
  belongs_to :user

  has_many :comments

  validates :subject, presence: true, length: { minimum: 3, maximum: 100 }
  validates :content, presence: true, length: { minimum: 3 }
end
