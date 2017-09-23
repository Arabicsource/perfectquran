# frozen_string_literal: true

# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Page < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true
end
