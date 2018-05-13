# frozen_string_literal: true

# == Schema Information
#
# Table name: bookmarks
#
#  id         :bigint(8)        not null, primary key
#  ayah_id    :bigint(8)
#  account_id :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :bookmark, class: Quran::Bookmark do
    ayah Quran::Ayah.first
    account
  end
end
