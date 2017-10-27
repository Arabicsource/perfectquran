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
#  permalink  :string
#
module Content
  # :nodoc:
  class Page < ApplicationRecord
    before_validation { self.permalink = title.parameterize }

    belongs_to :user

    validates :title, presence: true
    validates :permalink, uniqueness: { case_sensitive: false }
    validates :content, presence: true
  end
end
