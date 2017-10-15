# == Schema Information
#
# Table name: flags
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  comment_id :integer
#  ip_address :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Flag < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :comment

  validates :ip_address, presence: true
  validates :content, presence: true
end
