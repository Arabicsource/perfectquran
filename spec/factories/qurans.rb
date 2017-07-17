# == Schema Information
#
# Table name: qurans
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  language_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :quran do
    name "string"
    description "string"
    language
  end
end