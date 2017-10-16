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
#  approved   :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :flag do
    comment
    ip_address '127.0.0.1'
    content 'Reason Flagged'

    trait :approved do
      approved true
    end
  end
end
