# == Schema Information
#
# Table name: topics
#
#  id               :integer          not null, primary key
#  subject          :string
#  content          :text
#  discussable_type :string
#  discussable_id   :integer
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Topic < ApplicationRecord
  belongs_to :discussable, polymorphic: true
  belongs_to :user

  has_many :comments

  validates :subject, presence: true, length: { minimum: 3, maximum: 100 }
  validates :content, presence: true, length: { minimum: 3 }
end
